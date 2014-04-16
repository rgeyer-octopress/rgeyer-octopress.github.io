date: 2010-10-25 00:00:00 -0700
---
layout: post
title: RightScale crowd sources value-add content
comments: true
categories:
- Cloud computing
tags:
- cloud
- contest
- ipad
- linkedin
- RightScale
- servertemplate
- showdown
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://b2l.me/a2nwef
  _wp_old_slug: ''
  _sexybookmarks_permaHash: 02bb385ea316dcd24e980a38147360ae
date: 2010-10-25 00:00:00 -0700
---
RightScale is definitely doing the whole "social media thing" right.  They're active on <a href="http://twitter.com/rightscale">Twitter</a> and <a href="http://www.facebook.com/RightScale">Facebook</a>.  The CEO <a href=http://blog.rightscale.com/">blogs</a>, they have a community <a href="http://forums.rightscale.com/">forum</a> and the very nature of their product encourages users to interact and share with one another.  Clearly they've ticked all of the big social media checkboxes, but their latest announcement is sheer evil genius!
<!--more-->

<h2>How to motivate your users to add value</h2>
RightScale is holding a <a href="http://blog.rightscale.com/2010/10/07/rightscale-servertemplate-showdown/">contest</a> for the best Server Template submitted to the community.  They've also dangled the most trendy carrot available (a shiny new iPad) as the grand prize for winners in three categories.  This is social media 101.  Get the users involved, and motivate them to generate great content that drives interest and brings you even more users who will in turn create great content.  Plus, because it's a contest it gives users more incentive to share their best work with the community, rather than just the left overs.

What's really cool about this contest besides encouraging users to share their best work, is that it may also motivate them to really put the finishing touches on the templates and scripts which they may have already written.  In fact, that's exactly the effect it had on me when I read about the contest.

<h2>My ServerTemplate submissions</h2>
When we first started using RightScale to build out an infrastructure for our SaaS application at work, there were a few things we needed.

First, our application was going to use LDAP for authentication.  We needed a decentralized database for our users since we plan to have many different applications and websites that a user can access with the same credentials.

We were also leveraging the paid RightScale ServerTemplates <a href="http://www.rightscale.com/library/server_templates/Tomcat6-FrontEnd-v9/12326">Tomcat6 FrontEnd</a>, <a href="http://www.rightscale.com/library/server_templates/Tomcat6-App-Server-v9/12324">Tomcat6 Application</a>, and <a href="http://www.rightscale.com/library/server_templates/MySQL-5-1-EBS-v2/14192">MySQL 5.1</a> to build out our production deployment environment.  But we needed to be able to run all of these services on a single box for development, staging, and QA purposes.

<h3>OpenLDAP ServerTemplate</h3>
Thinking that an LDAP directory would be a pretty common requirement for infrastructure in the cloud I went searching the <a href="http://www.rightscale.com/library/">RightScale Library</a> for a ServerTemplate I could use out of the box, or modify a bit for our purposes.  Instead I was a bit shocked to find that there wasn't anything out there, which is why I built my <a href="http://www.rightscale.com/library/server_templates/OpenLDAP-Directory-Server-v1-1/14476">OpenLDAP Directory ServerTemplate</a>.

This is a ServerTemplate that we're currently using for our production environment to authenticate users, and it has some pretty cool features.  It allows you to easily setup a "Provider" and "Consumer" pair of servers, and allows you to easily promote the "Consumer" server in the case of a failure.  It also backs up the database daily to a file in an S3 storage bucket of your choice.

<h3>Tomcat6 All-in-One ServerTemplate</h3>
This <a href="http://www.rightscale.com/library/server_templates/Tomcat6-Java-or-Grails-App-Fro/14552">ServerTemplate</a> is a utility template that comes in handy if, like us, you're using the RightScript ServerTemplates mentioned earlier to host a Java application.  It combines all of the roles (Front End, Application Server, Database Server, and my own OpenLDAP server) into a single instance.

This allows you to setup parallel environments that are nearly identical to your production environment for the purposes of development, testing, or troubleshooting an issue in production.  We're running one of these that our continuous integration deploys to nightly for demo and smoke testing purposes.

One of the coolest features of this template is the ability to fire up a utility server which will exactly mirror your production environment.  This is done by grabbing the latest EBS volume snapshots your production server is creating for backups, then using those snapshots to attach new EBS volumes to your utility server.  This effectively duplicates the production database, allowing you to work with it in isolation.  This is great for staging a significant upgrade which might effect the database schema, you can bring up a "throw away" server instance, test and troubleshoot your upgrade, allowing you complete confidence that your upgrade will go off without a hitch in production!

<h3>One more for the road</h3>
I do have one other ServerTemplate that I'm putting some finishing touches on.  It's based on a collection of RightScripts and configuration stuff that I've compiled for our own development team server.  It provides services like git, svn, Teamcity, and artifactory.  I'm hoping to be able to submit it before the October 29th deadline.

So, for motivating me to step up my game and share my best work my thanks go to RightScale.  Ohh and, you're welcome for the value add, I just hope it's worthy of an iPad!
