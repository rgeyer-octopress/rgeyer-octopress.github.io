---
layout: post
title: Grails and Tomcat6 - Deployment Notes
categories:
- Grails/Groovy
tags:
- deploy
- grails
- linkedin
- path
- subcontext
- subdirectory
- tomcat6
status: publish
type: post
published: true
meta:
  _syntaxhighlighter_encoded: '1'
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/aSnNNw
  _sexybookmarks_permaHash: 73c90b7c1f632d295297c5abd5039c28
---
<p>Things have been busy, and I haven't had the time to devote to writing updates on either the Caddy, or my work in Grails.  But enough complaining, to pass the time until I can get some more quality content here, I wanted to share this little gem that took me entirely too long to figure out.</p>

<p>I wanted to be able to deploy my grails applications to a sub context, or sub directory of the root of my site.  This way I could leave my blog at the root of my domain, and categorize my grails apps a bit.  Take the following example.  Suppose I wanted to deploy a bunch of example grails apps in a subdirectory named "examples" off of the root of my web host.  Something like http://&lt;yourserver&gt;/examples/&lt;your-app-name&gt;.  This is how I was able to finally accomplish it.</p>

<h2>Deploy to a Tomcat Sub-Context</h2>
<p>If you're a Tomcat guru this is all going to seem elementary, and it is, but it was superbly difficult for me to mine the information I needed from the web, so I'm sharing what I've learned here.  If, on the other hand, you're a Tomcat newbie like me, you hopefully have a running instance of the Tomcat service.  If you don't there are a number of great tutorials, including the official <a href="http://tomcat.apache.org/tomcat-6.0-doc/appdev/installation.html">installation guide</a>.</p>

<p>Most of the stuff that you'll read out there says that to deploy your grails app, you just upload your *.war file to the Tomcat "webapps" directory and you're in business.  This is true, but of course when you do this, you just end up with a URL that looks like http://&lt;yourserver&gt;:8080/&lt;your-app-name&gt;.  Now, this is fine if you only intend to deploy a few apps and you dont mind that application being at the root for your domain/server name.  But we're trying to put our apps in a sub directory of our site, off of the root.</p>

<p>My first instinct to accomplish this was to use some of the properties of the grails app itself, and I found many examples which recommended this.  So, I happily set my app.context in application.properties to the path I wanted.</p>
<p class="filename">application.properties (snippet)</p>
[groovy] app.context=/examples/MyExampleApp [/groovy]

<p>This works great when I do a grails run-app, I get the app deployed to http://localhost:8080/examples/MyExampleApp just like I wanted.  But, when I create a war and toss it in my Tomcat webapps directory, I still get the same old behavior of the application being deployed to the root of Tomcat with the same name as the war file.  So how the heck do I deploy my war into a sub directory of my Tomcat site?!</p>

<p>The secret lies in not simply dumping your war file into an existing "context" for Tomcat, but instead creating your own, and pointing that context to your war file. The first step toward this is to prepare a place for our webapp directories, outside of the Tomcat root webapp directory.  I choose /srv/tomcat-webapps but you're obviously welcome to put this anywhere you like.  So let's create the directory where we're going to deploy our first example app.</p>

[bash]mkdir -p /srv/tomcat-webapps/examples/MyExampleApp[/bash]

<p>Now, we need to find the Catalina configuration directory for our Tomcat deployment.  On Ubuntu, which is the environment I'm using, this is at /etc/tomcat6/Catalina/localhost.  What you'll find there, are a number of XML files each one describes a "context".  You can define sub-contexts by using a special syntax in the filename which is just barely mentioned in passing in the <a href="http://tomcat.apache.org/tomcat-6.0-doc/config/context.html#Introduction">Tomcat docs</a>.  You can set a multi level context name by using the # character.  So lets create a new sub-context for our example app at the correct path.</p>

[bash highlight="2"]cd /etc/tomcat6/Catalina/localhost
vim examples#MyExampleApp.xml[/bash]

<p>Now we need to add the content to this context file which will tell Tomcat where to find the applications files. Remember back when we created a new directory for our tomcat webapps, this is where we'll use it.</p>

<p class="filename">examples#MyExampleApp.xml</p>
[xml]
&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;
&lt;context antiresourcelocking=&quot;false&quot;
docbase=&quot;/srv/tomcat-webapps/examples/MyExampleApp&quot; path=&quot;/examples/MyExampleApp&quot; privileged=&quot;true&quot;&gt;
[/xml]

<p>Now if you restart Tomcat, and unzip your war file to /srv/tomcat-webapps/examples/MyExampleApp you should be able to navigate to http://&lt;yourserver&gt;:8080/examples/MyExampleApp and see your application!</p>
