---
layout: post
title: Taking Route 53 to Optimized Website Performance
categories:
- Cloud computing
tags:
- linkedin
status: publish
type: post
published: true
meta:
  _edit_last: '1'
---
When Amazon announced it's Authoritative DNS service, cheekily named Route 53 a few things popped into my head immediately.  First, this should be a much easier way to get the effects of Dynamic DNS which we were currently leveraging <a href="http://www.dnsmadeeasy.com/">DNS Made Easy</a> for.  Secondly, I wonder how much of a performance boost using it might provide.
<!--more-->

Amazon's entire model for providing services through AWS is predicated on the idea of distributing load.  They have several availability zones for computing and storage, they have a Content Delivery Network (CDN) which will deliver your static web content to users at blazing speeds because it's coming from a data center as close to them as possible.

So why wouldn't that persist to their new DNS offering?

Turns out I wasn't the only one wondering this.  Brant recently revealed some performance and stability findings in a <a href="http://x-pose.org/2011/02/amazon-route-53-benchmark-comparisons/">blog post</a> about Route 53.

<h2>How does it improve speed?</h2>
With the increasing focus on the speed of websites, everything is getting optimized.  Image sizes, whitespace in your CSS and JS files, the number of additional files you load, etc.  Each of these techniques strips a millisecond or two off of the time it takes your browser to find and download all of the components which make up the page you're looking at.

But there is another facet of browsing the web which takes time, the DNS lookup.  See, your browser has no idea which server to send the request for "www.google.com" to, since servers are identified not by their domain or hostnames, but by their IP address.  DNS is used to translate the hostname you enter into your browser, into an IP address which can be used to actually locate the server.

Of course, this lookup takes time, and if you have lots of components on your page, perhaps even some from other servers, this time could add up.

Google launched a recursive DNS service for this some time back.  By using the recursive (think "cached") servers you could drastically improve your DNS lookup times which is demonstrated quite well in <a href="http://code.google.com/speed/public-dns/docs/performance.html">this FAQ</a> for the service.

The downside of course is that you only get the benefit if you change your computers network settings to use the Google DNS servers, and since the DNS data is cached it can lag behind when changes are made to the authoritative DNS records.

On the other hand, if you use Route 53 as the authority for your DNS records, every internet user will benefit from the performance boost of making a DNS request to a much closer (and faster) DNS server.  Sweet!
