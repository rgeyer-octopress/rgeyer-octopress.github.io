---
layout: post
title: How to resize billions of images in the cloud
categories:
- Cloud computing
- Linux
- php
tags:
- linkedin
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://b2l.me/a3jrav
  _wp_old_slug: ''
  _sexybookmarks_permaHash: 403dae2fa06719cbfda274c387b2d88c
---
As I was clearing out my RSS reader a few days back, I stopped to read a post on the Flickr dev blog about the "new" <a href="http://code.flickr.com/blog/2010/10/26/the-not-so-new-image-size-medium-640/">640px image size</a>.  In the article they lament that they wished they had made "Large" copies of all uploaded images because it would make generating the new 640px size easier.

This got me thinking, what if they did want to convert every image ever uploaded to this new size and cache it?  How would they do it? How much would it cost?  The more I thought about it, the more curious I became, so I launched a little research project to see what I could find out, and to show how I would work through the problem.
<h1>Approach</h1>
<h2>How to resize?</h2>
I tried searching to find out exactly how Flickr is resizing their images, but it is apparently a well kept secret.  There was a fair amount of speculation that they use Lanczos resampling, and my own research suggested it was a strong choice for quality resizing, so I chose to use it for the purposes of this experiment.

I wrote a very quick PHP script that uses ImageMagick with the Lanczos "filter" to do the work.  This resizer was built with this particular experiment in mind, but it is fairly flexible.  If you POST an image, and a value "largestDimInPx" it will resize the image and send it back as the response to the HTTP POST, thus the "RESTFul" name.  The resizer also accepts an array of parameters which it sends back in the HTTP header.  So if you were actually taking on a mass resizing project like we're proposing, you can pass the unique ID of the photo in your system and get it back when the resize is complete.

You can find the code for it over on my <a href="http://github.com/rgeyer/RESTful-PHP-Resizer">GitHub</a>.

<h2>Just how many images we talkin'?</h2>
Another carefully guarded secret it seems, is the total number of images that Flickr is currently hosting.  I did a lot of searching and tried a few naughty tricks to see if I could get the API or website to tell me, but it was to no avail.

Some previous "official" numbers were as high as 6 <em>billion</em> images.  So for the purposes of my test I assumed that they had 10 <em>billion</em> images that they wanted to resize to this new 640px image size.

<h2>CPU Cycles - Pick your poison</h2>
I have to assume that Flickr has a pretty impressive infrastructure built out, and that they have a huge amount of processing power at their disposal.  Still, to accomplish something like this it's unlikely that they'd reallocate existing resources.  The task is too monumental to just have a couple servers work at it.

I also have to assume that they're carefully optimizing their servers so that they don't have to build and maintain more than necessary.  So that begs the question, how do you get the processing horsepower necessary to convert all of these images?

Since I've recently been engrossed in creating and refining reusable <a href="http://www.rightscale.com/library/">RightScale ServerTemplates<a /> for our own servers in the </a><a href="http://aws.amazon.com/">AWS cloud</a>, my thoughts for a solution instantly gravitated toward launching a bunch of servers in the cloud for this purpose then terminating them when the task was done.  What I didn't know is if this made more sense than, say, buying a bunch of servers and configuring them to do the same task.

In order to do some tests, I created <a href="">ServerTemplate</a> which can be launched on AWS using RightScale that will immediately be able to start resizing images posted to it using my aforementioned PHP resizer.

<h1>The experiment</h1>
What I learned in short was...  This is a <b><em>HUGE</em></b> undertaking!  I also found that while any approach would probably be cost prohibitive, performing this resizing task using on-demand servers in the cloud is still the cheapest route by far.

<h2>Assumptions</h2>
First, some of the assertions for this exercise.

<ul>
  <li>The server(s) performing the resize task will be of the <a href="http://aws.amazon.com/ec2/instance-types/">m1.large</a> type from AWS</li>
  <li>Flickr has 10 <em>billion</em> images to convert</li>
  <li>Those images are (on average 12MP and about 4MB</li>
  <li>The images are being resized so that the largest dimension is 640px</li>
</ul>

You'll also find that as I describe the results, and the costs they represent, I conveniently exclude data transfer from my numbers.  This is actually intentional.  My goal is to compare just CPU time.

Yes, bandwidth has a tangible cost when you use it in the cloud.  But the same is true for a bare metal server doing the same task, not to mention the networking hardware which must be acquired, configured, and maintained.  So for the purposes of this experiment, only the cost of CPU cycles is really being examined.

<h2>Findings</h2>
With my new m1.large instance launched in the AWS cloud, and exposing the resizer service, I did a few tests to get a feel for just how long it would take to do all of this resizing.  What I found out pretty quickly was that the actual task of resizing the image actually only took around 1 second, sometimes less!  It should come as no surprise that the real time consumer in the process was I/O bandwidth.

Over my home cable connection (measures at 3.5Mbps up and 11.83Mbps down), using Firefox to post and FireBug to measure, it took an average of 12 seconds to complete the process of posting the image and receiving the response.  If I removed the overhead of Firefox and simply used a bash script and cURL, that dropped considerably to 8 seconds.

In an effort to get a "best case scenario" measurement, I copied the file to be resized onto the AWS instance, and ran the same cURL command locally.  On what can be effectively called "infinite" bandwidth, the process of posting, resizing, and fetching the result took about 2 seconds.

<h2>The tortoise and the hare</h2>
One very tangible benefit to using the cloud for this purpose though is the time to market for such a huge task.  You can imagine that if Flickr did decide to go ahead with this, they wouldn't really want to announce that they've started but that the process will take many months, or even years.  Assuming again that the per image resize time is 2 seconds, it would take one server just over 633 <strong>years</strong> to convert all of the images.  Something tells me that wouldn't exactly go over well.

Say that they wanted to convert all of the images in one week, at 2 seconds per image for 10B images, it would require just over 33,000 servers to convert that many images in the cloud.  What's more is that it would take effectively "no time" to deploy that many servers, use them for a week, then terminate them.  Try rolling out that many real, bare metal servers in that timeframe!

<h2>What's it gonna cost?</h2>
You might look at those results and think that these times are fairly reasonable.  However, if you take these figures and start multiplying them by ludicrously large numbers (like 10 <em>billion</em> for example), those reasonable numbers start to look very unreasonable.

Using these results, and (as I stated before) only accounting for CPU time, it would cost approximately $1.9M for Flickr to convert all of their images in the cloud.  That is assuming that they're connecting to the servers with effectively infinite bandwidth, ensuring that the upload and download transfer times for the image were less than 1 second (combined!).  Seems like a lot of money, but then it's a lot of images!

Compare that though, to building out a farm of bare metal servers to do the same task.  We've already established that we'd need a little over 33,000 servers to be able to convert all of the images in a week.  If we just take the lowest configuration Dell rack mounted server, the <a href="http://configure.us.dell.com/dellstore/config.aspx?c=us&cs=555&l=en&oc=MLB1931&s=biz">R-415</a> at a retail price of $4531, it would cost just over $149M, just for the hardware.  Worse still, the Dell doesn't actually have as much processing horsepower as an AWS m1.large does, so you'd probably significantly effect the time per image.

<h1>Conclusion</h1>
At the end of the day, any approach for converting all of those images would be cost prohibitive, and I'm betting Flickr won't be taking on this project.  Still, if I had to accomplish this task for real, I think I've demonstrated fairly convincingly that doing it in the cloud with on demand computing power is totally the way to go.

I'm not a mathematician or a statistician, and I did paint this topic with very broad strokes.  You can check my work with the simple <a href="https://spreadsheets.google.com/ccc?key=0AroG_EaGJ08tdHM5Z0syaWJBbkZkWnFqN3c2bFZ6OUE&hl=en">Google Spreadsheet</a> I created to track my results.  If this were an actual task, I'd be a bit more precise, but I wanted to show the differences between the approaches, without getting into too much minutia.

That said, discussion about factors I may have missed are welcome, I think you'll find that the delta in price for just the CPU horsepower between the cloud and a bare metal solution more than absorb any real differences I may have excluded.  ;-)
