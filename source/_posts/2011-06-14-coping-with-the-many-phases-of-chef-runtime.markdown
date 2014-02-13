---
layout: post
title: Coping with the many phases of Chef Runtime
categories: []
tags:
- linkedin
status: draft
type: post
published: false
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
---
Installing gems in the "normal way" does not work when you're trying to consume those gems using libraries/providers/definitions/recipes in the same chef runlist.

Need to use the hack

[code]
g = gem_package &quot;right_aws&quot; do
  action :nothing
end

g.run_action(:install)
[/code]
