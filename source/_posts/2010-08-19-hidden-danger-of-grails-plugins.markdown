---
layout: post
title: Hidden Danger of Grails Plugins
categories:
- Grails/Groovy
tags:
- artifacts
- code coverage
- downside
- grails
- groovy
- linkedin
- plugins
- technical debt
- test driven development
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://b2l.me/ajgvrb
  _wp_old_slug: ''
  _sexybookmarks_permaHash: b0cfe18198b31e90101522742f567c60
---
As a new developer to Grails you're probably in awe over the vast number of very powerful plugins which are available to you.  Without writing a single line of your own code you can do all sorts of cool things like interact with Twitter, Facebook, Amazon's S3 storage system, Apple Push notifications, Spring Security, and the list goes on and on.  As of this writing there are 447 plugins available in the official Grails plugin repository.

It is understandably tempting to leverage all of this code to simply bolt together an integrated solution which solves the problem you're facing.  But there is a downside to consuming someone else's code, particularly when you're doing test driven development.  Here are some things to consider before you pull the trigger and <em>grails install-plugin</em>.
<!--more-->

<h3>Using a cannon to kill a mosquito</h3>
When you adopt someone else's code by installing their plugin, you don't always know about all of it's capabilities.  You very likely did a quick google search, or a keyword search in the grails plugins and found something which appeared to solve the particular problem you were facing.  It is very likely though that the plugin you just installed can do what you need, and much MUCH more.

Worse still, it may end up bloating your code with a bunch of functionality that you don't need, while still not fully solving your problem!

<h3>I see a black box and I want to paint it white</h3>
If you're working on a sizable project and collaborating with a team, you're probably doing TDD, and you probably have a code coverage requirement for your tests.  When you install a plugin a lot of the appeal is that it will create a TON of functionality and Grails artifacts for you (controllers, domain classes, services, taglibs etc).  If you do have a code coverage requirement, that means that you have to address those new artifacts with tests.

This is a double edged sword.  On the bright side, you are forced to really understand what the plugin is doing with the artifacts it provides, and you might discover that you need to rewrite them or refactor them for your application.  The negative of course is that you have to expend the mental energy to understand what the author is doing, and how they're doing it.  Very quickly the functionality that you got "for free" isn't looking so appealing, and you might end up spending as much (or more) time understanding the plugins implementation as you would have to build your own functionality and tests.

<h3>The bad that comes with the good</h3>
You might have noticed that all but the most mainstream plugins for Grails are not always documented particularly well.  This can be a serious barrier to including a plugin in your project as well.  If you can't figure out how to make it work, or get a clear understanding of the inner workings, you may spend more time fiddling with it than leveraging it.

Another consequence of adopting the plugins code is that you inherit the plugins <a href="http://martinfowler.com/bliki/TechnicalDebt.html">technical debt</a>.  The plugin author had a specific problem domain in mind when she wrote the code.  If your problem domain is slightly different the compromises built into the plugin may be ones which you're not willing (or able) to accept.

<h3>Looking to the future</h3>
If you've considered all of these things, and decided that it's worth the effort to write the tests and accept the technical debt of a plugin, there is one last thing to consider.  What happens in the future?  What if six months go by and your requirements change, requiring more functionality than your current plugin choice supplies?  You could try to find another plugin which covers the new requirement, or you may have to extend the functionality of your chosen plugin.  If the plugin you've chosen is poorly documented or poorly coded this could be difficult, or impossible, forcing you to pay the price by rewriting all of the functionality provided by the plugin.

Consider too what happens if the plugin author stops maintaining the codebase.  When new versions of grails are released, the functionality of the plugin could break and you're once again forced to maintain code you didn't write.

<h3>Sometimes it's worth the risk</h3>
Of course, I would hardly discourage you from using the plugins that are available, they can be hugely beneficial and save you immense amounts of time.  The warning is just to consider the cost of "buying" another developers code and folding it into your solution.

Once you've considered all of these things and still decide that a plugin is right for your project you'll be much better prepared for the effort that comes with using it, and you might just appreciate the functionality that the plugin provides a teeny bit more.
