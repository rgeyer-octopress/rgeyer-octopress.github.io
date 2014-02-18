#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'cgi'

def convert_codeblocks(everything)
  fullcodeblock_regex = /<p class="filename">.*?<\/p>.*?\[\/.*?\]/m
  parts = /<p class="filename">(?<title>.*?)<\/p>\s*(?<block_open_tag>\[.*?\])(?<block>.*?)\[\/.*?\]/m

  scanmatch = everything.scan(fullcodeblock_regex)
  scanmatch.each do |match|
    title_block = match.match(parts)

    tag_parts = title_block[:block_open_tag].match(/\[(?<lang>[a-z]*)\s*(?<options>.*?)\]/)
    options = "lang:#{tag_parts[:lang]}"

    tag_parts[:options].split.each do |option|
      key_val = option.match(/(?<key>[a-z]*)="(?<val>.*?)"/)
      case key_val[:key]
        when "highlight"
          options += " mark:#{key_val[:val]}"
        else
          options += " #{key_val[:key]}:#{key_val[:val]}"
      end
    end

    format = <<EOF
{%% codeblock %s %s %%}
%s
{%% endcodeblock %%}
EOF

    booyah = sprintf(
        format,
        title_block[:title],
        options,
        CGI.unescape_html(title_block[:block])
    )

    everything.gsub!(match, booyah)
  end

  # Replace simple single line bash blocks now
  everything.gsub!(/\[bash\]\s*?(.*?)\[\/bash\]/m, "```\n\\1\n```\n")
  everything.gsub!(/\[code(?: lang="bash")?\]\s*?(.*?)\[\/code\]/m, "```\n\\1\n```\n")

  everything
end

def styles(everything)
  everything.gsub!("<b>", "<strong>")
  everything.gsub!("</b>", "</strong>")
  everything.gsub!("<i>", "<em>")
  everything.gsub!("</i>", "</em>")

  everything
end

def enable_comments(everything)
  everything.gsub!(/(title:.*?)$/, "\\1\ncomments: true")

  everything
end

def convert_hrefs(everything)
  # Posts
  everything.gsub!(/"http:\/\/www\.nslms\.com\/([0-9]{4}\/[0-9]{2}\/[0-9]{2}\/.*?)"/, "http://blog.ryangeyer.com/blog/\\1")

  # Categories
  everything.gsub!(/"http:\/\/www\.nslms\.com\/category\/(.*?)"/, "http://blog.ryangeyer.com/blog/\\1")

  everything
end

Dir.glob("../source/_posts/*.markdown").each do |file|
  puts "File: #{file}"
  str = ""
  File.open(file, "r+") do |f|
    str = f.read
  end
  str = convert_codeblocks(str)
  str = styles(str)
# I didn't make this idempotent, so only do it once.
#  str = enable_comments(str)
  str = convert_hrefs(str)
  File.open(file, "w+") do |f|
    f.write(str)
  end
end
