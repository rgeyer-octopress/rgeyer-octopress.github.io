---
layout: post
title: Policy for an S3 only Amazon IAM User
comments: true
categories:
- Cloud computing
- Snippets
tags:
- access management
- amazon
- aws
- cloud computing
- iam
- linkedin
- policy
- s3
status: publish
type: post
published: true
meta:
  _headspace_description: A simple Amazon IAM policy to allow a user full access to
    a single S3 bucket
  _edit_last: '1'
comments: true
---
Now that Amazon's Identity and Access Management (<a href="http://aws.amazon.com/iam/">IAM</a>) is more widely known, and you can use your IAM credentials to <a href="http://www.nslms.com/2011/04/04/enabling-aws-console-login-for-iam-users/">login to the AWS Console</a>, you might be wondering how to really leverage the IAM offering.
<!--more-->
One really good use for IAM is allowing access for specific users to specific S3 buckets.  This is what the IAM policy would look like.

```
{
  "Statement": [
    {
      "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::bucket_name_here"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::bucket_name_here/*"
    }
  ]
}
```


This contains three simple IAM statements.

<ol>
<li>The s3:ListAllMyBuckets for the entirety of S3 (arn:aws:s3:::*)</li>
<li>Full control of the specified bucket (bucket_name_here, in this case)</li>
<li>Ful control of the contents of the specified bucket</li>
</ol>

Sadly, there is no way to limit a user to which buckets are listed, instead you have to let them see all buckets which is accomplished by the first statement.

The second and third statement gives the user full control of the bucket itself, and it's contents respectively.  Assign this policy directly to a user, or a group that the user belongs to, and you're all set!
