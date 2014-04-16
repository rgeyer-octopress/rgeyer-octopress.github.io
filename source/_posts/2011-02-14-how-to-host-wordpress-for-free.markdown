---
layout: post
title: How to host Wordpress for Free
comments: true
categories:
- Cloud computing
- Linux
tags:
- amazon
- aws
- cloud
- email
- free tier
- hosting
- linkedin
- RightScale
- t1.micro
- virtual computing
- wordpress
- wordpress blog
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_permaHash: 0fd9a7655b2dedeccd2a46d4037290a2
  _sexybookmarks_shortUrl: http://bit.ly/dKsWl5
date: 2011-02-14 00:00:00 -0700
---
If you're looking to start a blog to promote your business, or boost your presence on the internet, you've probably heard of <a href="http://wordpress.org">Wordpress</a>.

You may also have heard about the <a href="http://en.support.wordpress.com/com-vs-org/">benefits</a> of hosting your own instance of Wordpress, but you're intimidated by the idea of setting up and maintaining your own server, or trusting your business to a shared hosting solution.

What if I told you that I've got a solution that'll let you run your Wordpress blog, on your very own server, with automated backups and disaster recover, completely free?

Wait wait! I know it sounds too good to be true, but don't leave just yet, hear me out...
<!--more-->

<h2>Amazon AWS Free Tier</h2>
First, let me be straight with you.  When I say "free" I'm referring to the <a href="http://aws.amazon.com/free/">free tier</a> of Amazon's virtual computing and storage platform AWS.

This free tier allows you to run their smallest instance free for one year.  In practice you actually end up paying them a very small sum (around $0.12 average for me thus far) each month for transfer costs to run a low to medium traffic blog.

After your first year of free usage has expried, it'll start to cost around $15 per month to keep using the same size instance.

<h2>Managed by RightScale</h2>
You may be looking at AWS and thinking that setting up your own server, and keeping it running and backed up would be a daunting task, and it can be.  That's where <a href="http://www.rightscale.com/">RightScale</a> comes into the picture.

RightScale offers a <a href="http://www.rightscale.com/products/free_edition.php">Free Developer Edition</a> that gives you access to their shared library of ServerTemplates.

In that library is one little gem that I published, expressly for the purpose of running a server that hosts my blog, a few sites for other domains I own, as well as all of the email traffic for my various domains.

In fact, you're reading this right now from a server running from <a href="http://www.rightscale.com/library/server_templates/Web-LAMP-Email-Postfix-vhost-A/17057">this ServerTemplate</a>.

<h2>Full Disclosure</h2>
Before I give you the skinny on how to start using these tools to host a Wordpress blog on your own virtual server, a few warnings are in order.

I am using <a href="http://www.opscode.com/chef/">Opscode Chef</a> to configure the server.  Chef support is currently in <em><strong>Beta</strong></em> on RightScale, meaning that they do not recommend you use it to configure and manage "Production" servers.

It also means that there can be some hiccups when you're launching and configuring a server with this ServerTemplate.

So, don't be surprised if the first time you launch your server, it doesn't work.  Try launching a second time.

Lastly, I can't take any responsibility for any loss of self esteem, data, productivity, or sanity.  You have been warned.

That said, I'm using this server to run the very blog you're reading, and I haven't had any significant glitches yet.  RightScale is working as we speak to improve their support for Chef and things will only get better from here.

Haven't scared you off yet? Okay, good..  Here we go..

<h2>20 Minute Quickstart</h2>
The RightScale management tool, and this ServerTemplate offer all sorts of cool functionality which we can explore later, but if you're in a hurry to get started here's all you need to know.

<ol>
<li>Go sign up for an <a href="http://aws.amazon.com/">AWS Account</a></li>
<li>Sign up for a RightScale <a href="http://www.rightscale.com/products/free_edition.php">Free Developer Edition</a></li>
<li>Enter your AWS credentials into the RightScale dashboard using <a href="http://support.rightscale.com/index.php?title=03-Tutorials/01-RightScale/3._Upgrade_Your_Account/1.7_Add_AWS_Credentials_to_the_Dashboard">these</a> directions</li>
<li>Browse to my <a href="https://my.rightscale.com/library/server_templates/Web-LAMP-Email-Postfix-vhost-A/17057">All-In-One ServerTemplate</a> and click "Import"</li>
<a href="/images/Screen-shot-2011-02-11-at-1.25.23-PM.png"><img src="/images/Screen-shot-2011-02-11-at-1.25.23-PM-300x220.png" alt="" title="Import ServerTemplate" width="300" height="220" class="size-medium wp-image-1026" /></a>
<li>Click "Add to Deployment"</li>
<a href="/images/Screen-shot-2011-02-11-at-1.05.02-PM.png"><img src="/images/Screen-shot-2011-02-11-at-1.05.02-PM-300x87.png" alt="" title="Add to Deployment" width="300" height="87" class="alignnone size-medium wp-image-1024" /></a>
<li>Pick the AWS Cloud closest to you and click "OK"</li>
<li>Change the "Instance Type" dropdown to "t1.micro", and select the "default" Security Group from the dropdown.  You can also provide you server a name, then click "Add"</li>
<a href="/images/Screen-shot-2011-02-11-at-1.04.40-PM.png"><img src="/images/Screen-shot-2011-02-11-at-1.04.40-PM-300x288.png" alt="" title="Server Details" width="300" height="288" class="alignnone size-medium wp-image-1023" /></a>
<li>Click the "Play" button, provide inputs for the Database Administrator password, Postfix DB password, and EBS volume size, then click "Save and Launch"</li>
<a href="/images/Screen-shot-2011-02-11-at-1.17.24-PM.png"><img src="/images/Screen-shot-2011-02-11-at-1.17.24-PM-300x124.png" alt="" title="Launch Server" width="300" height="124" class="alignnone size-medium wp-image-1033" /></a>
<a href="/images/Screen-shot-2011-02-11-at-1.13.36-PM.png"><img src="/images/Screen-shot-2011-02-11-at-1.13.36-PM-269x300.png" alt="" title="Server Inputs" width="269" height="300" class="alignnone size-medium wp-image-1025" /></a>
<p>And now.. We wait.. Until the instance is up and running..</p>
<li>Click on the server's nickname, then navigate to the "Scripts" tab</li>
<li>Run the "rjg_utils::aio_ebs_volume_enable_continuous_backup" operational script to make sure your server is backed up daily</li>
<li>Run the "app_wordpress::deploy" operational script to setup Wordpress for your domain</li>
<a href="/images/Screen-shot-2011-02-11-at-1.45.33-PM.png"><img src="/images/Screen-shot-2011-02-11-at-1.45.33-PM-300x151.png" alt="" title="Wordpress Deploy Inputs" width="300" height="151" class="alignnone size-medium wp-image-1036" /></a>
<li>Navigate to your websites URL (we used http://ec2.ryangeyer.com in this example) and setup your Wordpress preferences</li>
<a href="/images/Screen-shot-2011-02-11-at-2.27.07-PM.png"><img src="/images/Screen-shot-2011-02-11-at-2.27.07-PM-300x285.png" alt="" title="Configure Wordpress" width="300" height="285" class="alignnone size-medium wp-image-1044" /></a>
<li>Start Blogging!</li>
</ol>

<h2>What's Next?</h2>
That's really all there is to it.  As I mentioned the ServerTemplate does a number of other cool things, which you can read about in it's <a href="http://www.rightscale.com/library/server_templates/Web-LAMP-Email-Postfix-vhost-A/17057">description</a>.

The best part is that because this ServerTemplate is what I use for my own blog and email hosting duties, you can be sure that I'll keep it up to date, secure, and be adding features fairly regularly.

<h2>Drop me a note</h2>
If you followed these directions, or if you're using this ServerTemplate, or if you're having trouble, by all means drop me a note in the comments here.

I'll be happy to answer any questions I can, and I'd love to get a sense for how many people are out there running servers based on this template, it'll keep me motivated to publish more stuff in the public ServerTemplate library!
