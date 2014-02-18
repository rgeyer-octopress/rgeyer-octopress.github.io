---
layout: post
title: Its the grid.. bitches
comments: true
categories: []
tags:
- linkedin
status: draft
type: post
published: false
meta:
  _edit_last: '1'
---
<h2>Problem domain</h2>
I've got a huge collection of addresses, need to geocode them, then compare them to polygons representing US Census tracts to find the tract an address belongs to.  For Geo targeted marketing and foreign language speakers.

<h2>Local solution</h2>
<ul>
	<li>Pull addresses from list</li>


	<li>foreach address
<ul>
	<li>geocode</li>
	<li>store coords in db</li>
</ul>
/foreach</li>

	<li>Pull coords without census tract from list</li>

	<li>foreach coords
<ul>
	<li>locate within census tract</li>
	<li>store tract in db</li>
</ul>
/foreach</li>

</ul>


<h3>Problems with this approach</h3>
Biggest problem is that the code was very static & inflexible, heavily dependent upon my local machines environment, and can not be executed by the data owners.  They'd have to tell me new addresses are in the DB, and ask me to run the geocoding routine

<h3>Things that weren't exactly problems</h3>
Speed...  It wasn't "fast" but I could also get things done as quickly as I needed to.
Size of data... I'm exchanging two floats, and a 7 character string, not a lot of heavy lifting
Compute intensive.. The worst part is the (find a point in a poly) which is pretty trivial trig for any processor

<h2>Enter the cloud/grid</h2>

<h3>Why the grid?</h3>
distributed - lots of data fast
available - online, so anyone (whom I authorize) can use it without having to work through me.
scalable - I may only have a few hundred addresses to deal with right now, but if I suddenly had hundreds of thousands, I'd be stuck!
Just freakin cool - I get to work with awesome technology, and share my experiences here!

<h3>How the grid?</h3>

<h4>Job Producer</h4>
Can run anywhere, it's role is to break the job up into atomic units, upload any necessary data, and populate an input queue with jobs.

<ul>
	<li>Read all addresses w/o coords from db</li>
	<li>create work unit with address, unique id from db, and some config data</li>
	<li>push work unit to input queue</li>
</ul>

<h4>Server Array</h4>
Role is to monitor input queue for grid, and launch worker instances as necessary

<h4>Grid worker</h4>
A ruby gem available to premium RightScale accounts, monitors input queue, pops work items off, processes them using your application class (described below), pushes output, audit, and error information into consumer queues

<h5>Configuration bits</h5>

<h4>Grid application</h4>
Ideally just a ruby class which implements do_work(message_env, message) that is called by the grid worker

What is the message param?

<h4>Job Consumer</h4>
Consumes data in the output, audit, and error queues, doing something useful with the job results.

<h3>Some homework/challenges</h3>
Easily identifying & troubleshooting errors - lots of logging available, and pushed to S3 buckets and all sorts of good stuff.  A bit difficult to consume
Measuring time spent on a single "job" (many job units)
Measuring each job unit & displaying/consuming that information easily
Performance tuning - Instance size, instance quantity, number of application instances (workers) per worker node
