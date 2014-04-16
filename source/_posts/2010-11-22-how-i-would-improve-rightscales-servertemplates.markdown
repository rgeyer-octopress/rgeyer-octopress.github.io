---
layout: post
title: How I would improve RightScale's ServerTemplates
comments: true
categories:
- Cloud computing
tags:
- linkedin
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://b2l.me/a6rcxk
  _sexybookmarks_permaHash: e769d5a1f7cfe847e377b81b04936dbb
date: 2010-11-22 00:00:00 -0700
---
One of RightScale's key differentiators from other cloud management platforms is the concept of the ServerTemplate.

A ServerTemplate is like a blueprint of the server you want to launch in the cloud.  It defines things like what software and services will be installed and configured, what will be ready when the server boots, and what can be run periodically for maintenance during the lifetime of that server instance.

<!--more-->

ServerTemplates offer a great deal of power, and abstract a lot of the cloud specific dependencies but there's room for improvement.

<h2>Optional Boot Scripts</h2>
One of the cool aspects of ServerTemplates is that you can specify a set of scripts which will be run on your new server instance the moment it boots up.

These bootscripts can be customized by inputs that you provide for each instance of the server template, allowing you to customize the exact details of your server instance.

Once you've selected the inputs that will produce the desired server instance, you just press a button to launch and the server starts up with exactly the configuration that you specified.

<h3>Tweaked with metadata</h3>
The problem though, is that sometimes you might create a ServerTemplate which could be used in more than one configuration.  A great example is my <a href="http://www.rightscale.com/library/server_templates/Tomcat6-Java-or-Grails-App-Fro/14552">Tomcat All-In-One</a> template.  This template is designed to run every service necessary for various Grails applications.

However, depending on the actual instance I'm trying to start I won't need certain services, or I may need to configure some services differently for different purposes.

To accomplish this sort of functionality using the existing ServerTemplate functionality, I use optional input parameters for the scripts that control the outcome of those scripts.  The input <strong>LDAP_ENABLED</strong> determines if an OpenLDAP server is installed on boot or not, and the value of <strong>DB_SOURCE</strong> determines which scripts are used for setting up the database.

<h3>Configure it later</h3>
Another strategy is to only launch the common services at boot, and allow the user to initialize other services after startup using operational scripts.  I use this strategy on my <a href="http://www.rightscale.com/library/server_templates/Dev-Team-All-in-One-v1/14785">Dev Team All-in-One</a> ServerTemplate.

<h3>A better mouse trap</h3>
Neither of these approaches are particularly elegant though.  In the case of the optional inputs, you have to specify a lot more metadata for a server instance before you launch it, and it may not be immediately obvious that the consequence of setting a certain input is that a service you depend upon won't be installed or configured.

When you force the user to install the services they need after the server is booted, a lot of the convenience and agility afforded by ServerTemplates is lost.

A better solution to the problem is to allow scripts which are added to the boot section of a ServerTemplate to be flagged as <em>optional</em>.  This would mean that when a user clicks the "launch" button for their server instance, they would be prompted not only for the inputs necessary to start the instance, but they would also be asked to select which optional boot scripts should run.

In this model, the optional boot scripts should probably also be able to define dependencies.  For instance, an optional script for continuously backing up an LDAP server may be dependent upon an optional boot script used to install that LDAP server in the first place

Darryl Eaton eluded to the coming availability of optional boot scripts in his <a href="http://assets.rightscale.com/11-03-10-user-conference/41-UCB-Sharing-Best-Practices.pdf">presentation</a> at CloudExpo 2010 in Santa Clara, and I am anxious to see how it's implemented.  As a <a href="http://www.rightscale.com/ambassador/">RightScale Ambassador</a> I'm hoping to get a sneak peek of this as soon as it becomes available, and I'll be sure to share my experience.

<h2>Script Packs</h2>
Another feature that I think ServerTemplates are missing is the ability to group sets of scripts together into <em>packs</em>, then allow many instances of those packs to be assigned to a server instance with discret sets of inputs for each pack.

What exactly do I mean by that?

All of the existing ServerTemplates that you find in the library make the assumption that a particular server instance is only running one of any given service or application.

Take a look at all of the MySQL Database templates, they all operate under the assumption that you are running only one database.

The application servers?  Yup, those assume you're only running a single application on each server instance.

Now, in production for high traffic applications and services which demand easy and rapid scalability, that's exactly how your servers should be configured.  But what about lower traffic applications?

Take a small development team running an all-in-one server with a few applications running on it for smoke testing or experimentation.  Or a smallish business or social media personality who wants to host a website or two.

In both of the above cases a single m1.small EC2 instance could easily handle the load of even a few hundred users on a couple applications or services.

In fact I am exactly that sort of user.  I currently have six small Wordpress sites, and an email server all running on a single Linode VPS with just over 700MB of memory.  A single t1.micro instance running on Amazon could easily accomodate my needs, and with RightScale I can monitor and manage it a lot more effectively.

To that end I'm working on a ServerTemplate to run these services in a t1.micro instance with Ubuntu 10.10, stay tuned for details on that.

<h3>The workaround</h3>
One of the challenges I face is having a set of scripts which I want to do the same operations on each of my six sites.

Things like a script to install Wordpress to the proper directory, a script to update Wordpress in the proper directory, scripts to backup or restore the database, scripts to backup or restore the files under htdocs, etc.

The best way I've found to add these scripts to my ServerTemplate and allow them to act on all of these sites individually, is to include them all in the operational scripts section of the template.  Then when I launch my instance I leave the inputs for those scripts blank, requiring me to enter inputs which target a particular site when I run the script.

Obviously, this is error prone.  What if I mis-type the path to the site directory and accidentally install Wordpress in the wrong directory?  Or maybe I am planning a wordpress upgrade and I backup a sites database, then update a different site that hasn't been backed up because I provided the wrong inputs to the script.

<h3>Tightening things up</h3>
With a script pack I could group together all of the scripts that run against my various applications (database backup, htdocs backup, wordpress installation & updates, etc) into a pack and define (and save) the inputs for each distinct instance.  Being able to label each pack would be a nice touch too.

There could be a www.nslms.com pack which performs those operational tasks only on the assets specific to that site.

And a tasforwp.ryangeyer.com pack which performed those operational tasks only on the assets specific to that site.

A www.ryangeyer.com pack....  You get the idea.

Imagine adding one (or many) of these packs to the boot phase of a ServerTemplate.  You could setup several websites to be launched as soon as your server instance is ready, or restore all of them from a current backup.  This could be useful for scaling your server horizontally to a bigger instance.

If you combine optional boot scripts and script packs, you could do some really cool stuff.   You might take a clone of your existing multiple site instance, and using optional boot scripts, only launch one of the sites on a new instance, allowing vertical scaling.  Powerful stuff indeed!

<h2>What would you like to see?</h2>
These are the improvements I would love to see added to ServerTemplates to improve my ability to manage servers in the cloud, but what do you think?

Would these improvements appeal to you?

What else would help you create better, faster, smarter ServerTemplates?

Feel free to speak your mind in the comments!
