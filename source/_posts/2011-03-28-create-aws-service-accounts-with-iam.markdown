---
layout: post
title: Create AWS Service Accounts with IAM
categories:
- Cloud computing
tags:
- linkedin
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
---
I've been making use of Amazon Web Services (AWS) quite a lot lately.  In order to really enjoy the benefits of Cloud Computing (automation, agility, etc) I've had to use a number of tools to interact with AWS on my behalf.

All of these external tools ask for the same thing to enable them to make AWS API calls, your AWS Access Key ID, and your AWS Secret Access Key.  Common practice is usually to just hand over the main set of these credentials, but there is a better (more secure) way, using Amazon Identity and Access Management (IAM).
<!--more-->

<h2>What is IAM?</h2>
In September 2010, amidst very little fanfare (as is the Amazon way) Amazon released their Identity and Access Management offering.  To this day, the IAM is still technically in Beta, but it is stable tested offering.

As of this writing, you can only interact with the IAM via the API.  Amazon also makes a nice set of command line tools available which work equally well in Windows or *nix (including mac OSX) environments.

IAM is a set of tools which allow you to create user groups with defined security policies, as well as unique AWS users with their own credentials who can be assigned to those groups.

This is an extraordinarily powerful tool for managing your use of AWS.  No longer is every request to AWS made as your super user account, but you can assign particular users their own credentials to more easily control and audit what they're doing in your AWS environment.

This concept extends to services and tools you might use to manage your AWS environment as well.  Rather than handing over your super user credentials, you can create a unique key and secret pair for each management tool you use, effectively isolating that service.

Now it's true that you can already create many sets of credentials, and invalidate old ones using the <a href="http://aws-portal.amazon.com/gp/aws/developer/account/index.html?action=access-key">Security Credentials</a> link off of your account management in AWS, but these are all still super user credentials.  They still have the same level of access (full control) and any audit information for objects created by those keys show up as the super user.

With IAM you can restrict a set of credentials using an <a href="http://awspolicygen.s3.amazonaws.com/policygen.html">AWS policy</a>, to only the specific AWS API calls you want to allow that user to make, and the objects they create or interact with get audit data showing their username.  This makes it possible to know who (or which service) did what to objects inside your AWS environment.

Do you use a tool like <a href="https://addons.mozilla.org/en-US/firefox/addon/amazon-s3-organizers3fox/">S3 Fox</a> to manage the contents of your S3 buckets?  You can create a unique user and policy which allows access only to S3 calls, or even narrow it to a particular bucket, or filenames!

So, how exactly do you do that?  To best explain it, I'm going to walk through the steps necessary to create a new group and user, and then use those new credentials with RightScale my favorite tool for automating AWS.

<h2>Prerequisites</h2>
Before we get started, you'll need to go ahead and download the <a href="http://aws.amazon.com/developertools/AWS-Identity-and-Access-Management/4143">IAM Command Line Toolkit</a> (IAM CLI) and add the bin directory to your PATH environment variable.  Once you've done that, you're ready to follow the steps below.

<h2>Creating a Service Account</h2>
The first thing we'll want to do is create a security policy which we will apply to the service account.  Since RightScale helps to manage nearly every aspect of the AWS, the policy document is going to be quite simple, and will grant full access to all services.

Don't be too intimidated by the creating policies for more restrictive cases though, the <a href="http://awspolicygen.s3.amazonaws.com/policygen.html">Policy Generator</a> makes it easy.

So lets write out our full control policy somewhere to disk so that we can use it later.

{% codeblock /tmp/fullcontrol_iam_policy.json lang:bash %}
{
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
{% endcodeblock %}


With that out of the way, lets create a new IAM user group named <strong>RightScaleDash</strong> and upload our new policy file using the IAM CLI tools.

```
$ iam-groupcreate -g RightScaleDash
$ iam-groupuploadpolicy -g RightScaleDash -p FullControl -f /tmp/fullcontrol_iam_policy.json
```


Then, we create a new user named <strong>rsdash</strong> and assign the new user to the <strong>RightScaleDash</strong> group.  Note the <strong>-k</strong> parameter, this instructs the IAM CLI tools to create a new AWS key and secret pair.

```
$ iam-usercreate -u rsdash -g RightScaleDash -k
```


Some things like signing your custom Amazon Machine Images (AMI's) require an x.509 certificate, and RightScale has a place for entering this type of "credential" as well, so we'll create a self signed one for this example.

```
$ openssl genrsa -out iam.key 1024
$ openssl req -new -key iam.key -out iam.csr
$ openssl x509 -req -in iam.csr -signkey iam.key -out iam.pem
$ iam-useraddcert -u rsdash -f iam.pem
```


That's really all there is to creating your service account.  Once you've set things up you aren't locked in to your choices either.  At any time you can go back and add or remove security policies using the IAM CLI.

So now that we've set up our new user, let's configure RightScale to use it.

<h2>RightScale Configuration</h2>
These steps are very easy, I'm going to describe how you would change the credentials for an existing RightScale account since adding your credentials for the first time is handled by the RightScale setup wizard.

Once you've logged in, hover over the <em>Clouds</em> menu, then under <em>AWS Global</em> click the <em>Credentials</em> link.
<a href="http://www.nslms.com/wp-content/Screen-shot-2011-03-21-at-3.21.13-PM.png"><img src="http://www.nslms.com/wp-content/Screen-shot-2011-03-21-at-3.21.13-PM-300x97.png" alt="" title="Screen shot 2011-03-21 at 3.21.13 PM" width="300" height="97" class="size-medium wp-image-1168" /></a>

On the next page, click <em>Edit</em> then enter the newly created credentials into the appropriate fields.

That's it, you've just configured your RightScale account to use it's very own AWS credentials!
