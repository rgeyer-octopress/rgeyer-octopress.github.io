---
layout: post
title: Tools for updating an online image gallery
comments: true
categories:
- Linux
tags:
- automation
- bash
- linkedin
- Linux
- website management
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/cjCBgT
  _sexybookmarks_permaHash: bb1e4109f05eed571f8ca5f49850a606
---
Not long ago I shared my bash script for <a href="{{ root_url }}/2008/02/20/image-thumbnail-generating-script/">creating thumbnails</a> and manageable sized "big" images for an image gallery, or other image store.  Well, today I had to update an existing gallery with a pretty significant number of new images.  It occurred to me that I'd like to only convert new images rather than re-converting the whole lot.  Then, I'd like to simply upload the new files to my server in some automated way.

So here's the tools to do it.  It assumes you have the same layout for your pictures on your local drive as I do, which is as follows.
<ul>
	<li><strong><em>RootDirectoryForGallery</em></strong> -- This contains the full resolution pictures directly from your camera, and the following directories.
<ul>
	<li><strong><em>web</em></strong> -- This is a sub directory of RootDirectoryForGallery which contains the "big" web version of your image, and the thumbnails directory described below.
<ul>
	<li><strong><em>thumbnails</em></strong> -- This is a sub directory of web, and contains the thumbnail sized versions of the images.</li>
</ul>
</li>
</ul>
</li>
</ul>
The first step, is to copy your new pictures from the digital camera to your <strong><em>RootDirectoryForGallery</em></strong>.  Then, we want to get a list of the files that are new, so we run the following from the <strong><em>RootDirectoryForGallery</em></strong>.
<pre lang="bash">
diff . web/ | grep 'Only in \.: d' | awk '{print $4}' | grep jpg &gt;&gt; 3-6-08_update.diff</pre>
This creates a file in the <strong><em>RootDirectoryForGallery</em></strong> named "3-6-08_update.diff" which contains a list of only the new pictures, one per line.  Now, we want to use our image thumbnail script to convert only the new images to the "big" and thumbnail sized images.  I discovered that I needed to make a change to my script in order to do this.  Namely in the for loop I needed to enclose the command used to list files in "$()".  The modified script is shown below.  Notice the "$($SEARCH)" where there was previously just "$SEARCH".
<pre lang="bash">
#!/bin/bash

SEARCH=$1
SIZE=$2
DEST=$3

if [ $# -lt 3 ]
then
echo "You must pass three arguments 1) The search string (usually *.jpg) 2) The destination size I.E. 500x374 3) The destination directory"
exit 1
fi

for i in $($SEARCH)
do
        echo "Converting $i"
        convert -resize $SIZE $i -resize $SIZE +profile '*' $DEST$i
done</pre>
So with our edited script we convert the files.
<pre lang="bash">
/opt/imagethumbnail.sh "cat 3-6-08_update.diff" "800x600" "web/"
/opt/imagethumbnail.sh "cat 3-6-08_update.diff" "150×112 "web/_thb_"</pre>
Lastly, we want to upload just the changed files to our server.  We'll use rsync for this.  The paths, server name, and user name have been changed to protect the innocent.  ;-)
<pre lang="bash">
rsync -e ssh -av /path/to/local/copy/ yourusername@yourserver.com:/path/to/www/server/copy/</pre>
And there you have it, with just a few simple commands you've created thumbnails of all of your images, and uploaded just the new ones to your server.  Easy!
