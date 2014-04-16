---
layout: post
title: Enabling AWS Console Login for IAM Users
comments: true
categories: []
tags:
- linkedin
status: publish
type: post
published: true
meta:
  _syntaxhighlighter_encoded: '1'
  _edit_last: '1'
date: 2011-04-04 00:00:00 -0700
---
Last week, I told you how you can use Amazon's Identity and Access Management (IAM) offering to better secure the services and tools you use to manage your AWS environment with <a href="{{ root_url }}/2011/03/28/create-aws-ser…ounts-with-iam/">service accounts</a>.  Well on February 14th IAM got that much sweeter when they opened up the ability for IAM users to login to the AWS Console.
<!--more-->

In the previous blog post we covered how to create users and get an AWS Access Key ID and AWS Secret Access Key to use with the AWS API.  Well the IAM also offers the ability to allow those users to log into the AWS console.

This is significant because it allows you to give restricted access to users through the AWS console.  So you could have a user who is only able to launch new EC2 instances, but can not stop or terminate them.  You can have another user who can create EBS snapshots, but can not delete them or do anything with EC2 instances.  You can officially delegate a lot of responsibilities to other users who do not have to know anything about the AWS API in order to manage objects in your AWS environment.

<h2>Naming your AWS account</h2>
The first step to allowing IAM users to login is setting an alias for your AWS account.  Technically, this step is optional since you can use your account number to access the AWS console login for your account, but by providing a nickname for your account, you'll make it much easier for your users to remember.  It's the difference between https://123456789012.signin.aws.amazon.com/console/ec2/ and https://nickname.signin.aws.amazon.com/console/ec2/.  Best of all, it's just a simple oneliner if you already have the IAM CLI tools installed.

```
$ iam-accountaliascreate -a nickname
```


<h2>Enabling login for a user</h2>
Once you've created the account alias to make logging in much easier for your users, you'll want to grant them login permissions.  In this example, we're making the assumption there is already a user named <em>ryan.geyer</em>.

```
$ iam-useraddloginprofile -u ryan.geyer -p supersecretpassword
```


That's it, now you can direct the user to https://nickname.signin.aws.amazon.com/console/ec2/ and they can login with their own username and password.  Once they're logged in, they will only be able to access the AWS objects defined by the IAM policies for the groups to which they are assigned.
