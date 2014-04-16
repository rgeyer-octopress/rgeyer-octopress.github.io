date: 2011-06-14 00:00:00 -0700
---
layout: post
title: PHPUnit Quick Start
comments: true
categories: []
tags:
- linkedin
status: draft
type: post
published: false
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
date: 2011-06-14 00:00:00 -0700
---
```

sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover components.ez.no
sudo pear channel-discover pear.symfony-project.com

```


I got a warning about protocol being updated for pear.phpunit.de, so
```

sudo pear channel-update pear.phpunit.d

```


Finally
```

sudo pear channel-update pear.phpunit.d

```


Cause I'm mostly testing wordpress stuff, install mockpress
```

sudo pear upgrade -f http://www.coswellproductions.com/mockpress/pear/latest.tgz

```


XDebug for PHPUnit coverage, in XAMPP
http://blog.laaz.org/tech/2010/08/27/xdebug-with-xampp-on-mac-os-x/
