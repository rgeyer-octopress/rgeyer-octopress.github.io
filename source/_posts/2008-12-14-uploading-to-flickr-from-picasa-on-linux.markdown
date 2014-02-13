---
layout: post
title: Uploading to Flickr from Picasa on Linux
categories:
- Linux
- Photography
tags:
- digikam
- flickr
- fspot
- gentoo
- linkedin
- Linux
- picasa
- upload
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/bpwWFM
  _sexybookmarks_permaHash: ec5688593fda09239c560eec658871a3
---
When I performed my search for the perfect <a href="http://www.nslms.com/2008/09/25/photo-sharing-services/">photo sharing</a> solution, I fell in love with the Picasa desktop application.  I even discovered that there is a linux version.  However, as you'd likely expect, it didn't really play nice as far as uploading photos to any photo sharing site other than Google's Picasa Web Albums.

On windows, there is a great solution called <a href="http://jerryong.com/blog/2008/06/picasa2flickr-uploads-your-picasa-photos-directly-to-flickr/">picasa2flickr</a> which passes the desired photo's to the windows <a href="http://www.flickr.com/tools/uploadr/">Flickr Uploader</a>.  Again, for obvious reasons, this doesn't work well on linux.

So, having determined that it wasn't worth my time to pursue trying to get Flickr uploads working from Picasa on Linux, I started evaluating many of the other native options on linux, such as digikam and fspot.  While these more easily uploaded to Flickr, and had open API's, none of them worked quite the way I wanted, so I abandoned my search for a good solution.

Then, on a whim I did a Google search just a couple hours after Andy O'Neill made a <a href="http://ultrahigh.org/2008/12/09/picflick-picasa-to-flickr-export-on-linux/">blog post</a> about a button he wrote to import photos to Flickr from the Linux version of Picasa, named picflick.

I eagerly (re)installed Picasa3 on my Gentoo box using a beta ebuild found <a href="http://bugs.gentoo.org/show_bug.cgi?id=240406">here</a>.  Then installed his button.

After playing with it for a bit, I realized a few things didn't quite jive for me.

1) The script automatically resizes the image before uploading it to Flickr.  I prefer to upload all of my images at their original resolution, so this was a bit of a road block for me.

2) The script used a Perl module to upload to Flickr.  For the life of me, I couldn't seem to figure out how to get it authorized with my Flickr account to actually permit uploads.  I'm sure if I spent a bit more time and read a few more manuals I could have gotten it right, but it didn't quite work "out-of-the-box" for me.

3) I'd prefer to see the progress being made, rather than the beeps and tray notifications that Andy's script provided.

So, I stole the key part of his script, the part which translates Windows paths to *nix ones, and broke down the rest to simply pass the photos on to my preferred linux Flickr uploader, <a href="http://kflickr.sourceforge.net/wikka.php?wakka=Kflickr">KFlickr</a>

Here's the contents of my script, including the win2native function written by Andy.

<pre lang="bash" line="1">
#!/bin/bash

DEBUG=1     # debug to $LOG
LOG=/tmp/picflick.log
PICASA_WINE_DIR="$HOME/.google\/picasa\/3.0\/drive_c"  # Relative to $HOME
PICASA_WINE_DIR_NATIVE=`echo $PICASA_WINE_DIR |sed 's|\\\\||g'`

function debug() {
        if [ $DEBUG -eq 1 ]; then
                echo "$*" >> $LOG
        fi
}

# wine2native(): convert wine filename to native linux filenames
# Arguments: _name_ of variable which holds path
# Example: wine2native file  # not wine2native $file
function wine2native() {
        VAR=$1
        eval "VAL=\$$1"
        debug "Wine path: $VAL"
        # use '|' to delimit the paths
        VAL=`echo "$VAL" | \
                sed "s|C:|$PICASA_WINE_DIR|" | \
                sed 's|\\\\|/|g'`
        debug "Source file: $VAL"
        eval "$VAR=\$VAL"
}

# check we have the required dependencies
which kflickr > /dev/null || die "You need to install kflickr"

file=$1
wine2native file
DIR=`dirname "$file"`
EXT=${file##*.}
debug "START_UPLOAD"
for file in "$@"; do
        wine2native file
        KFLICKR="$KFLICKR $file"
done

debug "Launching kflickr with the following args $KFLICKR"
kflickr $KFLICKR

debug "Done"
</pre>

Now when I click the "Flickr" button in Picasa, it brings up the KFlickr app with all the pictures I selected ready to upload.  Thanks for the inspiration, and code bits to make this work Andy, I was too lazy to actually figure out what was necessary to pull the image paths from Picasa and use them.
