---
layout: post
title: Long Live the Nikon SB600
comments: true
categories:
- Photography
tags:
- F100 p3D
- inductor
- linkedin
- nikon
- repair
- sb600
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/dUwaVB
  _sexybookmarks_permaHash: 8c6fdc66ed7df5abe471e4ae933d8341
---
<img src="http://farm6.static.flickr.com/5121/5198512555_a35bc75da3.jpg" width="500" height="334" alt="Nikon SB600 Repair" class="aligncenter" />

It's been a bit over a year since I <a href="http://www.nslms.com/2009/09/07/like-a-flash-in-the-pan/">dropped my Nikon SB600</a>, rendering it useless.  When it happened I was able to disassemble the flash and identify the part which was damaged, but being a relative layman when it comes to circuit board components I didn't know what to replace it with.

Apparently though, I wasn't the only person to damage their SB600.  Nor was I the only one who popped out the jewelers screwdriver and did a post mortem.  <a href="http://www.nslms.com/2009/09/07/like-a-flash-in-the-pan/#comment-299074576">David</a> identified the part as a small inductor, and even provided the digikey part number that was the best fit to replace it.
<!--more-->

Armed with the knowledge that someone else had repaired their strobe which suffered a similar fate, I felt empowered to take on the project myself.  I ordered up half a dozen of the component from DigiKey and started psyching myself up for the project.

<h2>The repair</h2>
Now, I'm a pretty technically adept dude, and I'm not terrified to use a soldering iron.  That said, I'm also not an electronics wizard so I did approach this project with some trepidation.

It took me a while to get the remnants of the old inductor off of the circuit board.  The components on this board are all surface mounted, and I do not have a hot air rework station, just a simple soldering iron with a fairly sharp tip.  The inductor did finally yield to my persistence and patience though.

Soldering the new one on proved a tad more difficult though.  I had only one soldering iron, so I could only heat one of the two contact points at any given moment.  As a result the new inductor is connected, but one of the contact pads is actually elevated quite a bit on top of a glob of solder.  A little amateurish, but it gets the job done. 

<h2>Modz</h2>
Since I was going to have the flash disassembled again, and since I had recently read <a href="http://strobist.blogspot.com/2010/11/stereo-sweetener-for-18-sync-mod.html">this</a> little teaser over on strobist, I decided to improve my strobe at the same time.

My first attempt to complete this mod was a complete failure as I managed to reverse the trigger and quench leads.  I should have looked at <a href="http://www.flickr.com/photos/22880734@N03/3956975788/">this</a> and maybe I could have avoided that.  The failure was actually fairly hard to detect.  See..

Both the trigger and quench signals are just a short to ground, and the both happen in such quick succession (trigger to start the flash, quench to stop it after a specified time) that it all happened well within the sync speeds I was testing at (1/60 if I recall).  So it <em>looked</em> like the trigger was working, but the quench was not, when in actual fact the quench signal was triggering the flash and it was just popping at near full power! Oops!

After going back in and connecting the 1/8" stereo jacks leads to the correct pins, I was still getting the same issue.  This time though, it seems I have a problem with continuity between the quench pin and my stereo jack.

<h2>Results</h2>
At the end of the day, I chose not to try to fix the 1/8" stereo jack mod since I didn't want to pop the flash open again.  I'm quite happy with the repair, and while my mod wasn't quite as functional as I had hoped, it does give me the ability to trigger my SB600 using my radio triggers easily.
