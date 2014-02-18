---
layout: post
title: My First 64bit PC
comments: true
categories:
- PC Upgrade
- Worklogs
tags:
- 64bit
- amd64
- cinelerra
- gentoo
- linkedin
- Linux
- x64
- x86_64
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/dkVKqN
  _sexybookmarks_permaHash: 4a85e1108efa487f39fc51b39fade3fc
---
Time for the second installment of my worklog for my <a href="http://www.nslms.com/2008/09/05/the-upgrade-begins/">PC Upgrade</a>.

Well, I actually received all the bits from UPS Monday (is it Thursday already? sheesh).  I actually assembled the thing Monday afternoon/evening, and have been slowly installing software and getting it up to speed.

For the curious, and so I can brag a bit heres the parts list.
<ul>
        <li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16817104954">FSP Group SAGA+ 450R 450W ATX12V Power Supply</a></li>
	<li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16811119106">    COOLER MASTER Centurion 534 RC-534-KKN2-GP Black Aluminum & Mesh bezel / SECC Chassis ATX Mid Tower Computer Case</a></li>
	<li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16813121314">Intel BOXDP35DPM LGA 775 Intel P35 ATX Intel Motherboard - Retail</a></li>
	<li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16819115017">Intel Core 2 Quad Q6600 Kentsfield 2.4GHz 2 x 4MB L2 Cache LGA 775 Quad-Core Processor</a></li>
	<li>4 x 2GB = 8GB<a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16820134636"> Kingston 2GB 240-Pin DDR2 SDRAM DDR2 800 (PC2 6400)</a></li>
	<li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16814130378">EVGA 512-P3-N954-TR GeForce 9500 GT 512MB</a></li>
        <li><a href="http://www.newegg.com/Product/Product.aspx?Item=N82E16822148288">Seagate Barracuda 7200.11 ST3500320AS 500GB 7200 RPM</a></li>
</ul>

Now, this isn't quite bleeding edge stuff but it certainly brings me up to date and I'm quite happy.  Because I wanted just a ROCK SOLID setup and wasn't intending to overclock, I went with an Intel motherboard.  I didn't want to regret not getting enough memory, so I maxxed it out with 8GB.  I don't really game so the video card is nothing special, but I did want enough horsepower to drive my big monitor and take advantage of Vista's Aero theme and some of the cool linux eye candy that's in KDE4 etc.  I am NOT disappointed!

So far I've gotten Gentoo linux installed on the system.  The speed of compiling is admirable though not mind blowing.  One of the first things I installed though was <a href="http://cinelerra.org/">Cinelerra</a> and I loaded up some of my HDV source material.  While I should have expected as much I was able to play, edit, and render the HD in realtime!  WOO HOO!

I'm quite impressed with Gentoo, no hardware headaches, everything more-or-less worked out of the box.  I haven't quite got all my favorite apps installed and running but I trust it will be uneventful.

I'm in the process of moving my drives/data over from my old system.  I had a software RAID1 setup using mdadm which I've been able to bring back up on the new box.  Going to play with a RAID5 since I now have enough disks, and maybe simulate a failure to test recovery.  This should get my confidence up for building a linux software based RAID5 NAS box which is the next project.
