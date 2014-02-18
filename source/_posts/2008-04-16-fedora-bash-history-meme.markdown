---
layout: post
title: Fedora Bash History Meme
comments: true
categories:
- Linux
tags:
- bash history
- fedora meme
- linkedin
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/9W6i5j
  _sexybookmarks_permaHash: 16adc2689b65c3738d57275c3fa14093
---
I just learned about a Bash History Meme originated at <a href="http://planet.fedoraproject.org/">Planet Fedora</a> from a <a href="http://basildoncoder.com/blog/">blog</a> I read regularly.

In short, you run the following command in bash, and show your results.

<pre lang="bash">
history | awk '{a[$2]++ } END{for(i in a){print a[i] " " i}}'|sort -rn|head
</pre>

My results from my home box are as follows;
<pre lang="bash">
103 ls
59 cd
52 exit
38 vi
38 firefox
29 for
22 su
18 /opt/hdv/myworkflow.sh
14 ssh
13 diff
</pre>

Seems I'm unwilling to simply close my terminal window in KDE, but instead have to type "exit".  The "myworkflow.sh" script is a work in progress which I hope to one day post about.  It does stuff to help me convert and do post production on video from my HDV camcorder.  I've been using "diff" to compare original files with modified ones for web updates I've been doing for clients.

Here's the results from my web hosting box;
<pre lang="bash">
394 ls
212 cd
89 vi
77 exit
60 du
30 mv
28 rm
20 mkdir
19 pwd
12 cp
</pre>

Suppose there's nothing particularly interesting here.  I was checking a file upload progress in a very nasty way by calling "du", what can I say..  I'm lazy.
