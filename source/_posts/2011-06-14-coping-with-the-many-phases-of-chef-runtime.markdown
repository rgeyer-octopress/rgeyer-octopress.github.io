date: 2011-06-14 00:00:00 -0700
---
layout: post
title: Coping with the many phases of Chef Runtime
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
Installing gems in the "normal way" does not work when you're trying to consume those gems using libraries/providers/definitions/recipes in the same chef runlist.

Need to use the hack

```

g = gem_package &quot;right_aws&quot; do
  action :nothing
end

g.run_action(:install)

```

