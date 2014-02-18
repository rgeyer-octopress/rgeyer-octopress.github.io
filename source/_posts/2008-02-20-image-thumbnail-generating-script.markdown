---
layout: post
title: Image thumbnail generating script
comments: true
categories:
- Linux
tags:
- automation
- bash
- gallery
- linkedin
- Linux
- thumbnail generation
- web
status: publish
type: post
published: true
meta:
  blogger_blog: qwikrex.blogspot.com
  blogger_author: RyanG
  blogger_permalink: /feeds/posts/default/3762667476366537687
  syntaxhighlighter_encoded: '1'
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/b0wScF
  _sexybookmarks_permaHash: b1fed3eb86b0791225af1c49ccbb7298
---
I have often wished that I could easily convert several images to a smaller size simultaneously.  This is useful for batch resizing images for thumbnails, galleries, or use on the web.

On a linux system with imageMagick installed, you can use the script at the end of this post to batch convert the images.

I use it to create thumbnails and scaled images for my online <a href="http://www.nslms.com/gallery">photo gallery</a> using the following commands.
./imagethumbnail.sh "*.jpg" "800x600" "web/"

./imagethumbnail.sh "*.jpg" "150x112" "web/_thb_"

This creates a reasonable sized "large" image at 800x600 and a thumbnail at 150x112.  Makes managing new images in my gallery much easier.  Hopefully you'll find it useful too.

Contents of imagethumbnail.sh
<pre lang="bash">#!/bin/bash
SEARCH=$1
SIZE=$2
DEST=$3

if [ $# -lt 3 ]
then
echo "You must pass three arguments 1) The search string (usually *.jpg) 2) The destination size I.E. 500x374 3) The destination directory"
exit 1
fi

for i in $SEARCH
do
echo "Converting $i"
convert -resize $SIZE $i -resize $SIZE +profile '*' $DEST$i
done</pre>
