date: 2008-09-25 00:00:00 -0700
---
layout: post
title: Photo Sharing Services
comments: true
categories:
- Cloud computing
- Photography
- Reviews
tags:
- digital photo
- facebook
- flickr
- linkedin
- photo sharing
- photo storage
- picasa
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/aPYYXU
  _sexybookmarks_permaHash: 6769cb13dbc39ed6558b7ce3a73396df
date: 2008-09-25 00:00:00 -0700
---
Since I became a dad, and bought a dSLR I've been trying to figure out the best way to store and share my pictures of my son, and other interesting stuff I shoot.  As far as securely storing it locally, I have a sizable RAID setup that handles redundantly storing my pictures on two drives, but it's the sharing part that I've had some trouble with.

Initially, I was using my own web host and the rather nice PHP based <a href="http://spgm.sourceforge.net/">SPGM photo gallery</a> software.  The problem though, is that it's fairly tedious to resize and upload the images (I wrote a whole blog post about it <a href="{{ root_url }}/2008/03/06/tools-for-updating-an-online-image-gallery/">here</a>), and I have "only" 20GB of storage and 500GB monthly throughput.  When shooting at 10 megapixels I could fill that space up quickly.  Beyond that I knew that some of the web based sharing sites out there had some really cool features for sharing and organizing your photos.

So, the search begins.  I had some (I thought) fairly simple requirements.  I was hoping to have these requirements met by a free solution, but I was willing to pay a nominal subscription fee if I got everything I was after.  Here's the run-down of what was important to me.

<ul>
	<li>Ability to upload original sized images.  Some services have a limit to the size of each image</li>
        <li>Unlimited storage/uploads</li>
	<li>Sophisticated organization features.  This means unlimited "albums" and the ability to have an "album" hierarchy and probably some other stuff that the service would surprise me with</li>
	<li>Ability to use my images on my website, blog, forum posts, etc.</li>
	<li>Ability to have a gallery on my site which displays all of the public images from the photo sharing site</li>
</ul>

That's a fairly short list, and seems as though it should be fairly easy to match but surprisingly it isn't.

So let's break down the services I tried and how they stack up.  First, let me say that I did not try every service out there, I ruled some out just based on their feature set, some due to their obscurity etc.  Listed here are just the ones that I either discovered myself, or were directly suggested to me.  If you want to do your own search and want to see all of the services available, here are a couple links that I found useful during my search.

<a href="http://photo-sharing-services-review.toptenreviews.com/">Top Ten Reviews</a>
<a href="http://reviews.cnet.com/4520-6451_7-6245099-1.html">CNET Reviews</a>

<h3>Picasa</h3>
This was a fairly natural choice for me since I'm a pretty heavy user of Google services.  I use Gmail, Google Reader, Google Analytics, Google Calendar, Blogger (switched from blogger to wordpress), Google Docs, and YouTube.  Additionally, Picasa has a great desktop tool for uploading photos that acts as a great photo management tool on your local system as well.

Unfortunately, Picasa only allows you to organize your photos into albums with no hierarchy.  Also, while you can upload a photo in it's original size, the number of photos you can store is limited by your storage space.  You're given 1GB of space for free, and you can buy additional space on a yearly basis.  But again, shooting at 10 megapixels means I'm going to need a whole lot of storage space, and I suspect that even their 400GB plan for $500 a year would become insufficient sooner or later.

<h3>Facebook</h3>
To be honest, Facebook is actually what warmed me up to the idea of using a photo sharing service on the web.  So while it's technically not a photo sharing service I thought I'd talk about what I did and didn't like about the photo storage and sharing options it had.

First, I loved how easy it was to upload pictures and tag the subjects in the photo.  Facebook also had no limit to the number of photos I could upload.  Of course, those photos were downsized to a much more reasonable 604x404px, and their album hierarchy was also flat.  And perhaps the most annoying thing was that I couldn't share my pictures on my own web site and the galleries I made public I had to link directly.  For instance I can send you to my public album of <a href="http://www.new.facebook.com/album.php?aid=3616&l=53ace&id=1344570211">artistic shots</a> but I can't send you to a page that shows all of my public albums on Facebook.  If you had a Facebook account, and were added as one of my friends you could see them all, but that's cumbersome.

<h3>Snapfish</h3>
Frankly, I didn't get very far in evaluating this service.  There wasn't much public information about the services offered, and it had a requirement of buying some product from them at some specified interval in order to keep your account active.  As such, I never even signed up or tried it.

<h2>And the winner is....</h2>

<h3>Flickr</h3>
As it turns out, this had all of the features I wanted, plus some ones I didn't realize I wanted until I used them.

First, the negatives.  With a free account your only allowed to upload 100MB of files each month, and you're limited to 3 "sets" (Flickr's version of an album).  Also, you can't technically have a multi-level hierarchy of sets but there are ways to overcome that (more on this later).  Of course, those limitations are removed as soon as you buy a "Pro" account which is a paltry $25 per year.  Needless to say I went with that.

Now the good stuff!  While you can only have a flat hierarchy of sets, you can create "collections" which contain sets or other collections.  These can be nested up to 5 deep.  This more than handles my organization needs.  For instance, I'd like to categorize all of my pictures of my son, then break it down into particular types of events, then the specific event.  Something like "Baby Pictures -> Firsts -> Crawling, Walking, Solid Food, Etc.".

And if that organization is not enough, you can also tag a photo with keywords that are search able by the community, and act as a sort of metadata for organization.

Built right in is the ability to use your photo in a variety of sizes on your blog, forums, website, or whatever you like.  Even more exciting is that there are plenty of options for sharing your pictures on other sites, as well as a <a href="http://www.flickr.com/photos/rgeyer/">public landing page</a> for you.  They even offer an open API which I'm sure I'll find useful eventually!

So there it is.  After a fair amount of time spent searching I found the solution that works best for me.  Hopefully my comparison can help you if you're searching for a photo sharing service.
