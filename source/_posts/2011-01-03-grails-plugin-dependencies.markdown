---
layout: post
title: Grails Plugin Dependencies
categories:
- Grails/Groovy
tags:
- dependency
- grails
- linkedin
- plugins
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
  _sexybookmarks_shortUrl: http://bit.ly/h7tXAn
  _sexybookmarks_permaHash: 5b3289ff16214c230780f28d6aa22e3c
---
You just finished adding a shiny new plugin to your Grails project, and build some functionality around it.  You excitedly push it out to your deployment site and you're greeted with a NoClassDefException.  If this has happened to you, the complex and murky plugin dependency handling of Grails may be to blame.
<!--more-->

The release of Grails 1.2 introduced a DSL for defining your projects external dependencies using Ivy, by convention, in your BuildConfig.groovy file, and the villagers rejoiced.  Then, Grails 1.3 expanded on this successful design and allowed you to define your projects plugin dependencies in the BuildConfig.groovy file rather than having to run <em>grails install-plugin</em>.  The villagers prepared a sacrificial virgin, declared Grails as their new deity, and began a holy war to convert the nearby settlers.

But things may not be exactly as they appear..

Straight from the <a href=http://grails.org/doc/latest/guide/3.%20Configuration.html#3.7.1 Configurations and Dependencies">Grails documentation</a> we have this.

<blockquote>
Grails features 5 dependency resolution configurations (or 'scopes') which you can take advantage of:
-build: Dependencies for the build system only
-compile: Dependencies for the compile step
-runtime: Dependencies needed at runtime but not for compilation (see above)
-test: Dependencies needed for testing but not at runtime (see above)
-provided: Dependencies needed at development time, but not during WAR deployment
</blockquote>

So based on this you might assume you must specify all dependencies for each configuration individually, I certainly did.  Suppose that you're working on a project that has these plugins installed.

<ul>
	<li>fixtures-1.0.RC1.SNAPSHOT</li>
	<li>joda-time-1.1</li>
	<li>spock-0.4-groovy-1.7-SNAPSHOT</li>
</ul>

If you want the fixtures and joda time plugins loaded each time you do a compile, run-app, run-war, or war, and only include the spock plugin when you run test-app, you might assume your BuildConfig should look like this.

[groovy highlight="27"]
grails.project.class.dir = &quot;target/classes&quot;
grails.project.test.class.dir = &quot;target/test-classes&quot;
grails.project.test.reports.dir = &quot;target/test-reports&quot;

grails.project.dependency.resolution = {
  // inherit Grails' default dependencies
  inherits(&quot;global&quot;) {
  }
  log &quot;warn&quot; // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
  repositories {
    grailsPlugins()
    grailsHome()
    grailsCentral()
  }
  dependencies {
    // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
  }
  plugins {
    build ':fixtures:1.0.RC1.SNAPSHOT',
      ':joda-time:1.1'
    compile ':fixtures:1.0.RC1.SNAPSHOT',
      ':joda-time:1.1'
    runtime ':fixtures:1.0.RC1.SNAPSHOT',
      ':joda-time:1.1'    
    test ':fixtures:1.0.RC1.SNAPSHOT',
      ':joda-time:1.1',
      ':spock:0.4-groovy-1.7-SNAPSHOT'
  }
}
[/groovy]

Notice the duplication across all configurations?  In fact only the test configuration is different with the addition of the spock plugin.  Intuitively this would make sense, even if a particular phase didn't really require the plugin by including it you make sure all of the dependencies are available; better safe than sorry, right?

The problem is that these configurations interact with one another in subtle, and not clearly documented ways.  In actual fact what you've done above is excluded all plugins from every phase but test.  To achieve the desired result your build config would need to look like this instead.

[groovy highlight="19"]

grails.project.class.dir = &quot;target/classes&quot;
grails.project.test.class.dir = &quot;target/test-classes&quot;
grails.project.test.reports.dir = &quot;target/test-reports&quot;

grails.project.dependency.resolution = {
  // inherit Grails' default dependencies
  inherits(&quot;global&quot;) {
  }
  log &quot;warn&quot; // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
  repositories {
    grailsPlugins()
    grailsHome()
    grailsCentral()
  }
  dependencies {
    // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
  }
  plugins {
    build: ':joda-time:1.1'
    test ':fixtures:1.0.RC1.SNAPSHOT',
      ':spock:0.4-groovy-1.7-SNAPSHOT'
  }
}
[/groovy]

The scopes are in fact additive, so if you put all of your dependency declarations in the build scope they're automatically included in all other scopes.  In every other scope, by listing a dependency there it effectively adds it to that scope, and <em>removes</em> it from all other scopes.  That's why your deployed war file breaks.

Something else to look out for if you're working on an older project which used Grails 1.2 or earlier.  If you've used the <em>grails install-plugin</em> method of including a plugin in your project your application.properties file will list the plugins for your project.  This method of listing dependencies, and the "new" dependencies DSL for Grails 1.3+ do not mix well, so be sure to stick to one or the other!
