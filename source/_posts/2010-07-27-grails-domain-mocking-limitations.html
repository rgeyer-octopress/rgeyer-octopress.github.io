---
layout: post
title: Grails Domain Mocking Limitations
categories:
- Grails/Groovy
tags:
- grails
- groovy
- limitation
- linkedin
- mock
- withCriteria
status: publish
type: post
published: true
meta:
  _syntaxhighlighter_encoded: '1'
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://b2l.me/ac4762
  _sexybookmarks_permaHash: 08e1d8557445d384e4230add558783f1
---
So, I just threw out most of this morning trying to figure out why something which clearly <em>should</em> work was blowing up my unit test on a grails app.  To spare you the same pain I'm documenting it here.

The scenario is that I have Roles and Privileges as domain classes.  A role has many privileges, and any privilege may belong to one or more roles.  This is represented in domain classes pretty succinctly as;

<p class="filename">/grails-app/domain/com/nslms/mockdomainlimtations/Role.groovy</p>
[groovy]
package com.nslms.mockdomainlimitations

class Role {
  static hasMany = [privileges: Privilege]

  static constraints = {
  }
  String name
}
[/groovy]

<p class="filename">/grails-app/domain/com/nslms/mockdomainlimtations/Privilege.groovy</p>
[groovy]
package com.nslms.mockdomainlimitations

class Privilege {

  static constraints = {
  }

  String name
}
[/groovy]

So I can access all the privileges which belong to a role pretty easily, but what if I want to know all roles which a particular privilege belongs to?  Easy enough, we can look that up in a variety of ways.  Below I show adding a new closure to the privilege domain class which uses the <a href="http://grails.org/doc/latest/ref/Domain%20Classes/withCriteria.html">withCriteria</a> functionality of GORM to return all roles which have this privilege in the privileges map.  The new closure is in the highlighted lines.

<p class="filename">/grails-app/domain/com/nslms/mockdomainlimtations/Privilege.groovy (with new closure)</p>
[groovy highlight="10,11,12,13,14,15,16"]
package com.nslms.mockdomainlimitations

class Privilege {

  static constraints = {
  }

  String name

  def getRolesWithThisPrivilege = {
    Role.withCriteria() {
      privileges {
        eq('id', this.id)
      }
    }
  }
}
[/groovy]

Now, if you're doing proper test driven development (you are doing TDD, right?!), you'd probably already have a test written for this new closure that would look something like the highlighted lines of the test fixture below.  Notice lines 8 and 9 which are also highlighted to show that we're asking the framework to mock out the GORM methods on the role and privilege classes.

<p class="filename">/test/unit/com/nslms/mockdomainlimitaions/PrivilegeTests.groovy</p>
[groovy highlight="8,9,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32"]
package com.nslms.mockdomainlimitations

import grails.test.*

class PrivilegeTests extends GrailsUnitTestCase {
  protected void setUp() {
    super.setUp()
    MockUtils.mockDomain(Role.class)
    MockUtils.mockDomain(Privilege.class)
  }

  protected void tearDown() {
    super.tearDown()
  }

  void testAbilityToGetAListOfRolesAPrivilegeBelongsTo() {
    def role1 = new Role(name: 'Administrator')
    def role2 = new Role(name: 'User')

    def priv1 = new Privilege(name: 'ReadAll').save(flush: true)

    role1.addToPrivileges(priv1)
    role2.addToPrivileges(priv1)

    role1.save(flush: true)
    role2.save(flush: true)

    def roleList = priv1.getRolesWithThisPrivilege()

    assert roleList.size() == 2
    assert roleList == [role1, role2]
  }
}
[/groovy]

Even after you've implemented <b>getRolesWithThisPrivilege</b> on the Privileges domain class though, you'll find your test still fails with an error that looks like the following.

<p style="font-size: larger; font-style: italic; color: red;">No signature of method: com.nslms.mockdomainlimitations.Role.withCriteria() is applicable for argument types: (com.nslms.mockdomainlimitations.Privilege$_closure1_closure3) values: [com.nslms.mockdomainlimitations.Privilege$_closure1_closure3@8327473]</p>

In short, it's telling us that the <a href="http://grails.org/doc/latest/ref/Domain%20Classes/withCriteria.html">withCriteria</a> method of GORM isn't implemented in the context of our test.  Of course if you put the exact same code in an integration test you're golden.

<p class="filename">/test/integration/com/nslms/mockdomainlimitations/PrivilegeTest.groovy</p>
[groovy]
package com.nslms.mockdomainlimitations

class PrivilegeTest extends GroovyTestCase {
  void testAbilityToGetAListOfRolesAPrivilegeBelongsTo() {
    def role1 = new Role(name: 'Administrator')
    def role2 = new Role(name: 'User')

    def priv1 = new Privilege(name: 'ReadAll').save(flush: true)

    role1.addToPrivileges(priv1)
    role2.addToPrivileges(priv1)

    role1.save(flush: true)
    role2.save(flush: true)

    def roleList = priv1.getRolesWithThisPrivilege()

    assert roleList.size() == 2
    assert roleList == [role1, role2]
  }
}
[/groovy]

With this in place, you can run a "grails test-app -integration" and the exact same test which failed during unit testing will succeed.  This is of course because the entire grails bootstrapping occurs, and all of the artifacts (like domain classes) are wired up fully by the framework.

So the moral of the story?  If you're planning to test anything more than simple saves with GORM in your testing phase, consider putting the more complex stuff into an integration test.  Either that, or keep your eyes peeled for problems like this and be prepared to refactor.

Feel free to grab a copy of the test grails app I created for this example.

<del datetime="2010-12-26T23:15:20+00:00">svn export https://linode.nslms.com/svn_ro/MockDomainLimitations</del>

<em><strong><span style="color: #ff0000;">* UPDATE: This example app has a new home..</span></strong></em>
<p>Grab the project</p>
[bash]
git clone git://ec2.nslms.com/grails/blog_example_mock_limitations
[/bash]
