---
layout: post
title: Web development environment - "On The Go"
comments: true
categories:
- drupal
- php
- Software Development
tags:
- cygwin
- drupal
- eclipse
- freeagent go
- linkedin
- portable
- seagate
- web development
- webdev
- xampp
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  syntaxhighlighter_encoded: '1'
  _sexybookmarks_shortUrl: http://bit.ly/cFAt0n
  _sexybookmarks_permaHash: 385fe6cc410d6bc31b9a796dca853cd8
date: 2009-04-07 00:00:00 -0700
---
Over the past few weeks I've been spending most of my spare time developing a couple of web sites.  These sites are based on the Drupal CMS written in PHP.  And I've taken a bit of a crash course in Drupal module design.

When I set out developing these, I faced a challenge that I'd been aware of, but managed to avoid in the past.  How do I work on these projects in a predictable, constant environment, and still bring my code with me to work on my home machine, work machine, laptop, and anything else I happen to sit down in front of?

This blog post is about how I've accomplished this so far.  Read more after the break...
<h2><!--more-->Portable Storage Device</h2>
Your first inclination will probably be to install these tools on a USB thumb drive that you can easily store in your pocket.  And you'd be in good company, this was my first choice too.  However, after getting everything going, I quickly realized that it simply wasn't fast enough.  Others have reported different results, and a lot has to do with the particular device, and the file system (NTFS is best).

That said, I chose to go a different route, with fewer unknowns, and picked up a <a href="http://freeagent.seagate.com/en-us/hard-drive/portable-hard-drive/Free-Agent.html">Seagate FreeAgent Go 250GB USB harddrive</a>.  I picked it up with a docking port from our local Costco for $80 and it eliminates concerns I had about performance.
<h2><a name="File_Structure">File Structure</a></h2>
Throughout the rest of this article, I'm going to refer to files in my file structure, so I may as well show it to you so that these references can make sense.  This probably isn't the best layout, but it's what works for me.
<ul>
	<li>FreeAgent Go Root
<ul>
	<li>ampp
<ul>
	<li>lampp</li>
	<li>wampp</li>
	<li>shared
<ul>
	<li>htdocs
<ul>
	<li>&lt;code&gt;</li>
</ul>
</li>
	<li>mysql
<ul>
	<li>data
<ul>
	<li>&lt;databases&gt;</li>
</ul>
</li>
</ul>
</li>
</ul>
</li>
</ul>
</li>
	<li>Portable
<ul></ul>
</li>
	<li>cygwin</li>
	<li>libs
<ul>
	<li>java-runtime
<ul>
	<li>jre1.6.0_06</li>
</ul>
</li>
</ul>
</li>
	<li>Program Files
<ul></ul>
</li>
	<li>7-ZipPortable</li>
	<li>eclipse</li>
	<li>FirefoxPortable</li>
	<li>junction</li>
	<li>Rapidsvn</li>
	<li>soapui-2.5.1</li>
</ul>
</li>
</ul>
<h2>Foundation (AMPP)</h2>
The first thing we're going to needed is a good Apache, MySQL, PHP setup.  For this I did some quick googling and stumbled upon XAMPP.  This is an Apache Friends project that packages all the server side components I need.  You can check them out, and download it over at their <a href="http://www.apachefriends.org/en/xampp.html">site</a>.

I just downloaded the zip file, and extracted it to my drive at \ampp\wampp.  If you don't unzip this project to the root of your device, you'll need to run the "setup_xampp.bat" batch script supplied.
<h2>Shared Source &amp; Database Files</h2>
For the sake of organization, and the ability to run this system on both Windows and Linux boxes (see notes below about linux), I'm keeping my htdocs and MySQL database files outside of the normal directory structure of the XAMPP installation.

See my <a href="#File_Structure">File Structure</a> above..

This way all of the web files for my individual websites and projects go in the "htdocs" directory, while the database data files go in the "mysql\data" directory, making them easy to find.

Of course, this presents a problem since the XAMPP install won't be looking in those directories for the databases and code.  So, to solve this I've written another small batch script which lives in the "shared" directory.  This script uses the microsoft system tool <a href="http://technet.microsoft.com/en-us/sysinternals/bb896768.aspx">Junction.exe</a> to create links of my shared directories in the location that XAMPP is looking.  The junction.exe file is in an "Installers" directory on the drive, though I should probably move it somewhere more logical.  Here's the script that deletes old junctions, and creates new ones.  You'll want to run this when you move from computer to computer, since the drive letter of the USB drive will likely change, and the junctions are to absolute paths.  I put this file in \ampp\shared and it uses relative paths, so that's important.
{% codeblock refresh-junctions.bat lang:bash %}

for /d %%A in (htdocs\*) do "..\..\Portable\Program Files\junction\junction.exe" -d "..\xampp\%%A"
for /d %%A in (htdocs\*) do "..\..\Portable\Program Files\junction\junction.exe" -s "..\xampp\%%A" "%%A"

for /d %%A in (mysql\data\*) do "..\..\Portable\Program Files\junction\junction.exe" -d "..\xampp\%%A"
for /d %%A in (mysql\data\*) do "..\..\Portable\Program Files\junction\junction.exe" -s "..\xampp\%%A" "%%A"

{% endcodeblock %}


The requirement here of course is that you always create new sites by creating a directory in \ampp\shared\htdocs, and that any time you create a new database, you must move it's directory from \ampp\wampp\mysql\data\&lt;database&gt; to \ampp\shared\mysql\data\&lt;database&gt; then re-run the refresh-junctions.bat script while the MySQL server is not running.  But it's a fairly workable solution.
<h2>Integrated Development Environment (IDE)</h2>
Okay, so we've got a nice predictable, repeatable hosting environment.  Now to  write some code!

My personal choice of IDE is Eclipse with the PHP Development Tools (PDT).  Eclipse is by it's nature portable since it's a Java application, and the installation for the PDT is just to unzip it to a drive.  There are a couple of pitfalls though, and here's what I've done to overcome them.

First, since Eclipse does require the Java runtime you have two choices.
<ol>
	<li>Make sure that a current JVM is installed on any machine you intend to run your portable environment on.</li>
	<li>Carry a copy of the JVM with you!</li>
</ol>
I chose #2, and used instructions found <a href="http://www.jonlee.ca/how-to-run-eclipse-or-aptana-from-usb-drive/" target="_blank">here</a> to do it.  Basically, store a copy of the JVM on your disk and edit the Eclipse startup batch script to use your portable copy.  In my case, the JVM is in the Portable/libs/java-runtime directory as shown in my <a href="#File_Structure">File Structure</a> above.

Secondly, I thought it would be a good idea to just store my workspace on the portable drive as well, so I could keep all my settings with me.  Thus far I haven't found an elegant way to do this, since it apparently uses absolute paths for projects.  So instead I keep a workspace on each system I work on that has the settings.  I hope to find a better solution to this, and if I do I'll post it here.
<h2>Portable Firefox Browser &amp; Plugins</h2>
Alright, so now we've got a web server to show our code, a nice IDE to write code in.  What we need is a predictable way to view it all.  You could install your favorite browser on every computer you interact with, or you could bring it with you!  In my case, Firefox is my very favorite browser so I used <a href="http://portableapps.com/apps/internet/firefox_portable" target="_blank">Firefox Portable</a> so that I can take it and all my configuration preferences as well as Firefox Add-Ons with me.  My core set of Add-Ons which I find invaluable are..
<ul>
	<li><a href="http://getfirebug.com/" target="_blank">Firebug</a></li>
	<li><a href="https://addons.mozilla.org/en-US/firefox/addon/35" target="_blank">IE View</a></li>
	<li><a href="https://addons.mozilla.org/en-US/firefox/addon/60" target="_blank">Web Developer</a></li>
</ul>
<h2>Portable *NIX tools with Cygwin</h2>
So we've written some code in our portable IDE, we've tested it out using our portable web server and Firefox browser and we're satisfied with the results, and want to upload them to our production server.  My very favorite method of doing so is over RSYNC so I transfer only what's changed, and it's secure.  In order to do that, I usually use cygwin.

On the surface it seems like it'd be easy to just install cygwin to a directory on your portable drive.  And in part, it is.  You can simply install to that directory, and you're all set.  Problem is as soon as you move it to another computer, and that computer assigns your drive a different drive letter, everything breaks down real quick.  Some quick google searching revealed a way to make this work.  I had to make some minor tweaks in order to fit within my <a href="#File_Structure">File Structure</a> but you can find the inspiration for my changes <a href="http://www.dam.brown.edu/people/sezer/software/cygwin/" target="_blank">here</a>.

My changes are to the X.bat and uninstall.bat files.  I instead called them ~cygwin-install-X.bat and ~cygwin-uninstall.bat and put them in the cygwin install directory at Portable\cygwin.  Here they are.

{% codeblock ~cygwin-install-X.bat lang:bash %}

for /F %%A in ('cd') do set WD=%%A
bin\mount -m | bin\sed s/mount/"%WD%\/bin\/mount"/ > tmp\mount.log
bin\umount -c
bin\umount -A
bin\mount -bfu %WD%/ /
bin\mount -bfu %WD%/bin /usr/bin
bin\mount -bfu %WD%/lib /usr/lib

set path=%path%;%WD%\bin;%WD%\usr\X11R6\bin
start bin\rxvt.exe -title "" -bg "#fafad2" -fg "#000040" -color10 green4 -color14 brown -fn "Lucida Console-14" -geometry 80x58+0+0 -sl 4000 -sr -tn rxvt -e /bin/bash --login -i
set DISPLAY=localhost:0.0
run usr\X11R6\bin\XWin -multiwindow -emulate3buttons 200

{% endcodeblock %}


{% codeblock ~cygwin-uninstall.bat lang:bash %}

bin\umount -c
bin\umount -A
bin\bash  tmp\mount.log
bin\rm    tmp\mount.log

{% endcodeblock %}


<h2>Portable Source Control (SVN)</h2>
Lastly, you'll probably want to submit your changes to some sort of source control.  In my case I'm using Concurrent Versioning (CVS) or Subversion (SVN) for my source control, and both are handled nicely by the portable version of <a href="http://portableapps.com/node/13470" target="_blank">RapidSVN</a>.

So there you have it, my end to end solution for doing web development from a portable flash drive on any windows box you happen to come across.  My original intention was to be able to just plug this drive into any windows OR linux box and work, but I have some kinks to work out with the linux solution.  Watch this space for more on that as I develop it.

Hopefully this helps you if you're trying to setup a nice portable webdev environment!
