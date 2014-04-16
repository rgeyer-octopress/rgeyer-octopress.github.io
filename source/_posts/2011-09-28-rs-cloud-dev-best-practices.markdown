---
layout: post
title: RS & Cloud Dev best practices
comments: true
categories: []
tags: []
status: draft
type: post
published: false
meta:
  Hide OgTags: '0'
  Hide SexyBookmarks: '0'
  _headspace_description: ''
  _headspace_page_title: ''
  _edit_last: '1'
date: 2011-09-28 00:00:00 -0700
---
I am often asked about best practices for developing, testing and debugging ServerTemplates.  This is my attempt to condense some of the best and most useful bits to make it easier for developers to create and publish some awesome templates.

I'm going to break this down into two categories.  First will be general guidelines applicable to any ServerTemplate, and the second will be more focused on ServerTemplates which use Chef for configuration management.

<h1>Launch once test many</h1>
One of the early pitfalls I fell victim to was relaunching my server instance for each change to each script when testing.  As you might imagine this practice can be excruciatingly time consuming!  With that in mind here are some tips on how to reduce the time between making a script change and testing it on a running instance.

<h2>Super size me</h2>
Let's face it, bigger is actually better when it comes to instance sizes.  Larger instances are provisioned and boot faster, they run your installation and configuration routines faster and they just generally make your life easier.

I develop a lot for small Amazon EC2 t1.micro instances.  These instances are seriously restricted in terms of CPU capacity and memory.  As a result, simple activities like installing and compiling ruby gems can be very taxing and time consuming.  As a result, I tend to run significantly higher end instances while doing development.  Running a c1.medium in place of a t1.micro (when targetting a 32bit image) results in a lot less waiting while launching and terminating instances and testing configuration.  The added hourly cost of a faster instance should be more than offset by the optimized use of your time.

<strong>RS</strong>
Create a dev & prod RepoPath, keep dev at head/master


<strong>Any</strong>
Keep instances up and run scripts against them as operational scripts (or equiv).  On RS, use the rs_agent_dev only DL once option and dev/test on the box.

Stop, Don't terminate.

::File, not File
