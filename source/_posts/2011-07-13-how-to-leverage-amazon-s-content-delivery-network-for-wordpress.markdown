---
layout: post
title: How to Leverage Amazon's Content Delivery Network for Wordpress
comments: true
categories:
- Cloud computing
tags:
- amazon
- amazon s3
- aws
- cdn
- content delivery network
status: draft
type: post
published: false
meta:
  _edit_last: '1'
date: 2011-07-13 00:00:00 -0700
---
For visitors to your blog, one of the biggest factors that contributes to the load time of the page is the static content.  Stuff like pictures, CSS, Javascript files, etc.

One of the best ways you can improve this performance is to serve those things from a Content Delivery Network (CDN).  Follow along as I show you how to configure your Wordpress blog to use Amazon S3 as a CDN for delivering static content!

<!--more-->

<h1>What you'll need</h1>
<ul>
	<li>An Amazon AWS account</li>
	<li>The <a href="http://wordpress.org/extend/plugins/tantan-s3/">Amazon S3</a> plugin for Wordpress</li>
	<li>The <a href="http://wordpress.org/extend/plugins/ossdl-cdn-off-linker/">CDN Offlinker</a> plugin for Wordpress</li>
</ul>

The first step is going to be setting up the S3 bucket where you're going to host your files.

Since we're going to be handing over access to the AWS API for S3 to a Wordpress plugin, we should create a new <a href="{{ root_url }}/2011/03/28/create-aws-service-accounts-with-iam/">IAM Service Account</a> and set up a <a href="{{ root_url }}/2011/06/27/policy-for-an-s3-only-amazon-iam-user/">security policy</a> which restricts that accounts access to only the S3 bucket we setup.

The next thing we want to do is upload all of the content from our /wp-include and /wp-content directories up to the bucket we created.

Make sure to "Make Public" everything you uploaded.

Once we've done that, we can go enable our Wordpress plugins.  First enable Amazon S3 plugin.

Wordpress Admin -> Settings -> Media -> Set the path for media
