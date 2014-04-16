---
layout: post
title: Amazon GPU instance - Bcrypt Cypher provider
comments: true
categories: []
tags:
- linkedin
status: draft
type: post
published: false
meta:
  _edit_last: '1'
date: 2011-06-14 00:00:00 -0700
---
A lot of things have been said about how the new Amazon GPU cluster compute instance could be a serious threat for brute force password cracking, but what if you were to fight fire with fire?

Use a GPU cluster instance to hash your passwords for you, using an obscenely high "cost" value, using bcrypt.  Would take even this massively powerful instance ~100ms to hash, and you would has inbound passwords to compare them against stored hashes as well.  Nutz, right?

You could then have your GPU cluster instance setup expressly for the purpose of hashing these passwords, and store them elsewhere, confident that they are secure.

Fight fire with fire.
