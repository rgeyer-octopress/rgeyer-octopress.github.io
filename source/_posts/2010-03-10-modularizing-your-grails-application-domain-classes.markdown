---
layout: post
title: Modularizing your Grails Application - Domain Classes
comments: true
categories:
- Grails/Groovy
- Reviews
tags:
- grails
- groovy
- linkedin
- modular
- mvc
- reusable
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
  _sexybookmarks_shortUrl: http://bit.ly/9vaoly
  _sexybookmarks_permaHash: 6a10d86a8a6b0bba0c5316c6ff15d5de
---
<p>This is the second installment of my <a href=http://blog.ryangeyer.com/blog/2010/02/05/what-grooves-you/>What Grooves You?</a> series of posts, this time discussing how to modularize your Grails application.  While Grails does an awesome job of enforcing <a href="http://www.grails.org/Developer+-+Spring+MVC+Integration">MVC</a> once your application reaches a certain size, or you have multiple applications which may have shared components, you're going to have to start thinking about how your going to modularize the reusable parts of your code.</p>
<!--more-->
<p>I encountered this pretty quickly because the application I am working on is broken out into two distinct parts, a public facing web form for submitting data (the "Front End") and a private back office application for managing those user submissions (the "Back End").  These two parts of the application (for compliance reasons) cannot run on the same internet facing system, and the "Back End" must only be available on the internal network.  Of course, both of these applications are going to work with the same database and therefore the same Domain classes.  It would be dangerous and tedious to try to keep the separate domain classes in each project synchronized with one another.</p>

<h2>What won't work</h2>
<strong>The RESTful JSON Service</strong>
<p>My first thought was to deploy a 3rd application which would be internet visible and act as a proxy for all the database requests.  I could then query that application with REST and handle a JSON payload which would be my domain object.  This actually seemed pretty elegant since I wouldn't have to actually share any code between the Front End and Back End applications and I still got a well defined object on either end.  The problem of course is that all I get is the data for my domain class, and I don't have access to any of the functionality that GORM gives me "for free".  I'd have to duplicate search functionality, limits, grouping, sorting, and all sorts of other querying tools in my service.  That seemed like an awful lot of work for functionality that is offered by GORM and works very well!</p>

<strong>Just JAR it man</strong>
<p>The next obvious conclusion is to just toss my domain classes into a library JAR file and reference that library in both of my other applications.  This way I actually have the whole domain class and access to the dynamic find methods and all that other good stuff.  But, how do you package these?  Do you compile the Groovy classes then package the .class files? Will the data source information have to be set for the domain class(es) in the JAR, or will the data source of the application referencing the library be used?</p>

<p>Now some more seasoned Java and Hibernate developers might simply laugh at that barrage of questions, but for me it presented a serious barrier to entry.  Fortunately there is a better way.</p>

<h2>Just plug it in!</h2>
<p>It didn't take me long to discover that putting my reusable code into a <a href="http://grails.org/doc/latest/guide/12.%20Plug-ins.html" target="_blank">Grails Plugin</a> was the best and most scalable approach. For the sake of demonstration I'm going to take you through an example comment submission and administration application, kinda like blog comments.</p>

<strong>The plugin project</strong>
<p>First, let's go ahead and create our plugin project.</p>
```
grails create-plugin Modular-DAL
```

<p>Once you've got your shiny new plugin created, open it up with your favorite IDE (I use <a href="http://www.springsource.com/products/sts">Spring Source Tool Suite</a>) and add a new domain class that you're going to be sharing.</p>
```
grails create-domain-class com.nslms.modular.domain.Comment
```

<p>Now we specify some properties for our new shared domain class.</p>
{% codeblock Comment.groovy lang:groovy %}
package com.nslms.modular.domain

class Comment {
	
	static constraints = {
		name(blank:false)
		email(blank:false)
		comment(blank:false)
	}
	
	String name	
	String email
	String website
	String comment
	
	Boolean isApproved = false
}
{% endcodeblock %}

<p>With our new shared domain class created, we want to package up our plugin so we can load it into the other projects which we'll be creating in a moment.</p>
```
grails package-plugin
```

<p>That's it, you've just created a (very small) module of your application which contains a shared domain class.  This could, of course, contain any number of domain classes, controllers, or services, views, javascript, css, etc. that would be used by other parts of your application, or by other applications.</p>
<strong>The Front End</strong>
<p>Now, lets create an application which will serve as the "front end" or externally facing form for collecting data.</p>
```
grails create-app Modular-FrontEnd
```

<p>Then the very important part of installing the plugin we just created</p>
```
grails install-plugin ../Modular-DAL/grails-modular-dal-0.1.zip
```

<p>Because you can <a href="#download-instructions">download</a> the project I created, I'm not going to go into excruciating detail about the controller and view(s) I setup in my front end, but sufficed to say I am accessing the "Comment" domain class that is supplied by the Modular-DAL plugin project!</p>
{% codeblock CommentsController.groovy (snippet) lang:groovy mark:1,5 %}
import com.nslms.modular.domain.*

class CommentsController {

    def index = { [comments: Comment.findAllByisApproved(true)] }
}
{% endcodeblock %}

<p>The result of the front end app should be a list of comments which are approved (by the backend) and a submission form to allow you to submit new comments. <!-- Kinda like <a href="http://www.nslms.com/grails/examples/modular/frontend/comments" target="_blank">this</a>. --></p>

<strong>The Back End</strong>
<p>Now we need to create the system which will allow you as the administrator to approve the comments submitted by the unwashed masses.</p>
```
grails create-app Modular-BackEnd
```

<p>And install the plugin with the shared domain class.</p>
```
grails install-plugin ../Modular-DAL/grails-modular-dal-0.1.zip
```

<p>Again because you can <a href="#download-instructions">download</a> the project I created, here's just a snippet of the admin controller showing the juicy bits where we use the shared domain class</p>
{% codeblock AdminController.groovy (snippet) lang:groovy mark:1,5 %}
import com.nslms.modular.domain.*;

class AdminController {

    def comments = { [comments: Comment.findAllByisApproved(false)] }
}
{% endcodeblock %}

<p>The back end app should have a list of all unapproved comments, and a method to approve them.  <!--Kinda like <a href="http://www.nslms.com/grails/examples/modular/backend/admin/comments" target="_blank">this</a>.--></p>

<strong>Trying it out</strong>
<p>Now if you've followed along and created your own controllers and views, or <a href="#download-instructions">downloaded</a> my basic project, you're going to want to try running both the front end and back end at the same time, persisting data to a common datasource so that you can see the whole thing in action.  If you just use the grails run-app command, you'll find very quickly that you can only run one or the other project, but not both at the same time.  This is because they'll both be trying to run on the common Tomcat port (8080).  To overcome this, and run both apps at the same time, try the following starting from the Modular-FrontEnd directory.</p>

```
grails -Dserver.port=8081 run-app
cd ../Modular-BackEnd
grails -Dserver.port=8082 run-app

```

<p>Now you should be able to access both applications at <a href="http://localhost:8081/FrontEnd">http://localhost:8081/FrontEnd</a> and <a href="http://localhost:8082/BackEnd">http://localhost:8082/BackEnd</a> respectively.</p>

<b id="download-instructions">Download The Project(s)</strong>
<p>If you want to download the project(s) and follow along, fire up your favorite subversion client and export everything at <del datetime="2010-12-26T22:17:49+00:00"><a href="svn://linode.nslms.com/blog/grails/Modular">svn://linode.nslms.com/blog/grails/Modular</a></del> or download it <a href="http://www.nslms.com/downloads/Modular.zip">here</a>.  A couple things to note if you're grabbing my project, it's currently setup to use a MySQL database named "modular" running on the same system as the application.  If you don't already have MySQL setup, give <a href="http://www.apachefriends.org/en/xampp.html">XAMPP</a> a look to get you started quickly.  Also, I didn't include the JDBC driver, go fetch it <a href="http://www.mysql.com/downloads/connector/j/">here</a> and drop it into the "lib" directory of both the FrontEnd and BackEnd applications.  Lastly, these projects are all written with Grails 1.2.1 so you'll have to be using 1.2.1 or newer.</p>

<em><strong><span style="color: #ff0000;">* UPDATE: The example apps have a new home..</span></strong></em>
<p>Grab the projects at</p>
```
git clone git://ec2.nslms.com/grails/blog_example_modular
```

