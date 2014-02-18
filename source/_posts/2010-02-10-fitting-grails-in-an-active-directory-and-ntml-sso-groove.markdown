---
layout: post
title: Fitting Grails in an Active Directory and NTLM SSO Groove
comments: true
categories:
- Grails/Groovy
- Reviews
tags:
- Acegi
- Active Directory
- Authentication
- grails
- groovy
- linkedin
- NTLM
- Spring Security
- SSO
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
  _sexybookmarks_shortUrl: http://bit.ly/9gVkUA
  _sexybookmarks_permaHash: b5231441e0dea4a9c69c8856c431e301
---
<p>This is my first installment in the <a href=http://blog.ryangeyer.com/blog/2010/02/05/what-grooves-you/>What Grooves You?</a> series of posts, and it deals with the first thing you're going to need to consider if you are deploying your Grails/Groovy applications in the average corporate IT infrastructure, Single Sign On with Active Directory and NTLM.  Like it or not, because all of our existing applications are based on Microsoft technologies our users have gotten used to just going to the URL for the application they intend to use and being instantly recognized and authenticated.  Forcing them to sign in again, or worse still forcing them to setup a new username and password for your system would be completely unacceptable!  Below, I'll take you through the steps I took to solve this problem, including the detours that cost me time!</p>
<!--more-->

<p>Throughout this post I'll be referring to domain objects, controllers, and views which would have been created by running the <a href="http://www.grails.org/AcegiSecurity+Plugin+-+LDAP+Tutorial">Acegi LDAP tutorial</a>.  So if you want to follow along, go walk through the tutorial, then come back here to see how we tweak it.  Be sure to take the "optional" step of creating the views and controllers for the auth domains, you'll need it not only in the tutorial, but also for some customization we'll be doing later.

```
grails generate-manager
```


You can also download a copy of the Spring Source STS project I used for this application <a href="http://www.nslms.com/downloads/GrailsInActiveDirectoryGroove.zip">here</a>.
</p>

<h2>LDAP Single Identity but not Single Sign On</h2>
<p>As I started searching to figure out how to authenticate my users, everything seemed to point to using the <a href="http://grails.org/plugin/acegi">Acegi Plugin</a> for Grails, and using it with LDAP, tweaked to talk to Active Directory.  So, I started down this path and followed the <a href="http://www.grails.org/AcegiSecurity+Plugin+-+LDAP+Tutorial">LDAP tutorial</a> for the Acegi plugin.  Without a lot of trouble I got this working by following the steps in the tutorial, though I did make a couple significant changes to the SecurityConfig.groovy file to make it play nice with Active Directory</p>
{% codeblock SecurityConfig.groovy lang:groovy mark:14,17,18 %}

security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true
	
	useLdap = false
	ldapRetrieveDatabaseRoles = false
	ldapRetrieveGroupRoles = true
	ldapServer = 'ldap://<your-domain-controller>'
	ldapManagerDn = '<your-service-account-dn>'
	ldapManagerPassword = '<your-service-account-password>'
	ldapSearchBase = 'OU=People,DC=yourdomain,DC=com'
	ldapSearchFilter = '(sAMAccountName={0})'
	ldapSearchSubtree = true
	ldapGroupSearchBase = 'CN=Users,DC=yourdomain,DC=com'
	ldapGroupSearchFilter = 'member={0}'
	ldapUsePassword = false

	loginUserDomainClass = "User"
	authorityDomainClass = "Role"
	requestMapClass = "Requestmap"
}

{% endcodeblock %}



<p>By setting ldapSearchFilter to '(sAMAccountName={0})', we're telling the Acegi plugin to look for the field in Active Directory that stores the username, this means that users can login just like they're used to by using their Active Directory user name and password.</p>

<p>The ldapGroupSearchBase and ldapGroupSearchFilter are set such that any domain user groups that a user is a member of become Acegi "Roles" which can be used to determine if a user has authority to do stuff in the application.</p>

<p>Setting ldapUsePassword to false is important too.  What we're telling the Acegi plugin is not to extract the users password from Active Directory.  If you don't set this to false, you'll get a lovely exception which isn't particularly useful, <strong><em>java.lang.IllegalArgumentException: Cannot pass null or empty values to constructor</em><em></em></strong>.  What this is trying to tell you is that the users password is null, which is correct since the default setting for the Acegi plugin is to try to extract the users password from Active Directory, and we haven't told Acegi what attribute Active Directory stores the password in.  By setting ldapUsePassword to false, the plugin provides a bogus password for the user details, and we're able to proceed without incident.</p>

<p>So, great!  If you've made these changes and followed the steps in the tutorial to add a user  to the application domain with the same username as your Active Directory user you can authenticate users with the username and password they're already using to login to their computer, we have a single identity for this person.  But remember, our users are used to simply going to a URL and not being prompted to login.  How do we reproduce that experience?</p>

<h2>NTLM Really Single Sign On</h2>
<p>Having realized that using Active Directory/LDAP authentication works, but isn't an actual single sign on solution I started looking into the other settings in the <a href="http://www.grails.org/AcegiSecurity+Plugin+-+Customizing+with+SecurityConfig">SecurityConfig.groovy</a> file.  Turns out there is an NTLM option, but no corresponding tutorial!  Here's my configuration for using NTLM.
</p>
{% codeblock SecurityConfig.groovy lang:groovy %}

security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true
	
	useNtlm = true
	ntlm.stripDomain = false
	ntlm.defaultDomain = "yourdomain.com"
	ntlm.netbiosWINS = "<your-domain-controller-ip>"

	loginUserDomainClass = "User"
	authorityDomainClass = "Role"
	requestMapClass = "Requestmap"
}

{% endcodeblock %}



<p>Nothing really outstanding here, I chose to set ntlm.stripDomain to false, so that the users name is not prefixed by the domain, I.E. DOMAIN\username.  Also ntlm.defaultDomain and ntlm.netbiosWINS are both required, and I found that the ntlm.netbiosWINS works better if you actually give it the IP address of your domain controller, rather than the DNS name.</p>

<p>With NTLM configured, our Grails app now accepts the users cached authentication from their windows session.  True single sign on!</p>

<h2>Securing the Security Controllers and BootStrapping</h2>
<p>Now we've got an application which will use NTLM to authenticate the user, we restrict access using the requestmap, and we add users and their roles using the user and role controllers.  The problem, of course is that if you deploy this application anyone can go right to http://yourdomain.com/sso-app/user and add themselves as a user with any roles they see fit!  So we need to make sure that our security controllers are secured, and that there is an authorized user that can get in to add users and roles.</p>

<strong>Securing the Security Controllers</strong>
<p>The first thing we're going to want to do is secure our authentication controllers.  My preference is to do this with annotations on the controllers, so lets secure the UserController and RoleController with annotations.  Shown below we annotate them to show that the "ROLE_USER_ADMINISTRATOR" role is necessary to access any of the pages for either controller.
</p>
{% codeblock UserController.groovy lang:groovy mark:1,3 %}

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

@Secured(["ROLE_USER_ADMINISTRATOR"])
/**
 * User controller.
 */
class UserController {
	/* Snip */
}

{% endcodeblock %}

{% codeblock RoleController.groovy lang:groovy mark:1,3 %}

import org.codehaus.groovy.grails.plugins.springsecurity.Secured;

@Secured(["ROLE_USER_ADMINISTRATOR"])
/**
 * Authority Controller.
 */
class RoleController {
	/* Snip */
}

{% endcodeblock %}


<strong>Enabling the @Secured annotation</strong>
<p>Now if you were simply to run the application like this, you'd find that you can still freely navigate to /user and /role without having to be authenticated, that's because we are still configured to use the Requestmap to restrict access to specific parts of our application.  To configure this for use with annotations instead, we only need to make a couple of small changes to the SecurityConfig.groovy file.</p>

{% codeblock SecurityConfig.groovy lang:groovy mark:14,16,17 %}

security {

	// see DefaultSecurityConfig.groovy for all settable/overridable properties

	active = true
	
	useNtlm = true
	ntlm.stripDomain = false
	ntlm.defaultDomain = "yourdomain.com"
	ntlm.netbiosWINS = "<your-domain-controller-ip>"

	loginUserDomainClass = "User"
	authorityDomainClass = "Role"
	//requestMapClass = "Requestmap"

	userRequestMapDomainClass = false
	useControllerAnnotations = true
}

{% endcodeblock %}


<p>Setting useControllerAnnotations to true gives the @Secured annotations on the user and role controllers meaning.  By setting userRequestMapDomainClass to false we tell the Acegi security plugin to not even query for restrictions in the database, but to use only the static configuration defined by the annotations.  We also delete the requestMapClass line.  I commented it here instead of deleting it so it can be highlighted as a change in the file, but we're not quite done with the requestmap yet.  Now that we've configured our application not to use the request map we can delete the controller, domain, and views for it.  Go ahead and delete the following files.

<ul>
  <li>/grails-app/controller/RequestmapController.groovy</li>
  <li>/grails-app/domain/Requestmap.groovy</li>
  <li>/grails-app/views/requestmap/*</li>
</ul>
</p>

<strong>BootStrapping</strong>
<p>Now that we have our app secured, and we're using annotations to restrict access we need to make sure that some user can successfully login after we first deploy our application.  Otherwise no one will be able to access the pages to add new users!  So we use boot strapping to add a user administrator who can add more users and roles for the application.</p>

{% codeblock BootStrap.groovy lang:groovy %}

class BootStrap {
	def authenticateService
	
	def init = { servletContext ->
		def role = new Role(authority: 'ROLE_USER_ADMINISTRATOR', description:'User Administrator')
		role.save()
		def user = new User(username: 'admin',
				userRealName: 'Administrator', 
				passwd: authenticateService.encodePassword('foobar'), 
				enabled: true, 
				description: '', 
				email: '', 
				emailShow: false)
		user.addToAuthorities(role)
		user.save()
     }
     def destroy = {
     }
} 

{% endcodeblock %}


<p>So there you have it, an application which allows users to connect using their cached authentication using NTLM, uses annotations to secure your controllers, and actually allows access to at least one user once it's deployed.  Now, there are still some weaknesses.  Particularly the level of permissions you can assign is limited to roles, I.E. "Administrator", "User", "Reporting User", "User Administrator", etc.  Also in a corporate environment, having to go through this configuration for every grails app, and adding users and assigning their roles for each app can be tedious.  I'll be looking into improving these things with Acegi ACL's and possibly using a centralized database for users and roles in future articles so stay tuned!</p>
