---
layout: post
title: Drupal Flickr Module.  Now with URLs!
comments: true
categories:
- drupal
- php
tags:
- drupal
- flickr
- flickr.urls.getUserPhotos
- linkedin
- php
- urls
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _sexybookmarks_shortUrl: http://bit.ly/9uoCWA
  _sexybookmarks_permaHash: ec682a6b92fa453f3ff4403edfb56b52
---
<p>Okay, so I've been a bit preoccupied with a couple projects which have slowed my efforts at blogging etc.</p>
<p>In both cases, I've been working on websites that leverage the PHP based Drupal CMS.&nbsp; One of those projects is over at <a href="http://www.chasejarvisshoeproject.com">http://www.chasejarvisshoeproject.com</a>.&nbsp; That site is basically a small community forum for some folks that are sending a pair of shoes around the world, and taking pictures of them in various locations and situations.&nbsp; Pretty cool.&nbsp; The result of this effort is a Flickr photo pool and a good time.</p>
<p>So, of course a website devoted to a group on Flickr, is going to require some integration with Flickr.&nbsp; Enter the <a href="http://drupal.org/project/flickr">Drupal Flickr Module</a>.&nbsp; When I&nbsp;started using it, this module was still in either an alpha, or beta (can't seem to remember) and has released it's 1.0 as of the 25th of March.&nbsp; Throughout the time I've been using it however, there've been a few functions of the Flickr API which I&nbsp;needed, and the module didn't support.&nbsp; Those were.</p>
<ul>
    <li><a href="http://flickr.com/services/api/flickr.groups.pools.getPhotos.html">flickr.groups.pools.getPhotos</a></li>
    <li><a href="http://flickr.com/services/api/flickr.urls.getGroup.html">flickr.urls.getGroup</a></li>
    <li><a href="http://flickr.com/services/api/flickr.urls.getUserPhotos.html">flickr.urls.getUserPhotos</a></li>
</ul>
<p>Since the framework of the module did the hard work of making the calls, it was easy to write my own methods which performed these Flickr API&nbsp;functions for me.&nbsp; And as the module developers released new versions, I&nbsp;just copy/pasted my code back into the new file, and went about my business.</p>
<p>Well when 1.0 was released, I&nbsp;took a closer look.&nbsp; It turns out they'd implemented the call to get photos from a group pool, but still nothing for the URL's.&nbsp; So I&nbsp;figured I'd contribute and write a patch for the two calls I&nbsp;was still in need of.&nbsp; And that, is what you see here.</p>
<pre lang="diff">
569,597d568
< }
< 
< /** 
<  * @param $nsid
<  *   nsid of the group whose pool url will be returned
<  * @return 
<  *   The URL portion of the response from the flickr method flickr.urls.getGroup
<  */
< function flickr_urls_get_group($nsid)
< {
<   $response = flickr_request('flickr.urls.getGroup', array('group_id' => $nsid));
< if($response)
<     return $response['group']['url'];
<     
<   return FALSE;
< }
< 
< /**
<  * @param $nsid
<  *   nsid of the user whose photostream url will be returned
<  * @return unknown_type
<  */
< function flickr_urls_get_user_photos($nsid)
< {
<   $response = flickr_request('flickr.urls.getUserPhotos', array('user_id' => $nsid));
< if($response)
<     return $response['user']['url'];
<     
<   return FALSE;
</pre>
<p>As you can see, pretty basic but I&nbsp;figured I'd contribute.&nbsp; I&nbsp;posted this as a feature request/issue over on the Flickr Module's <a href="http://drupal.org/node/414096">issue queue</a>, but have yet to receive a response.&nbsp; If nothing else, I&nbsp;can use this to patch the next version.&nbsp; Hopefully it helps someone else as well.</p></pre>
