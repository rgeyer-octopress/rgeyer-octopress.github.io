---
layout: post
title: RightScriptDiff - Maintain your RightScripts Locally
comments: true
categories:
- Cloud computing
- Linux
tags:
- API
- cloud
- compare
- diff
- linkedin
- RightScale
- RightScript
- rsDiff
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
  _sexybookmarks_shortUrl: http://b2l.me/aemxqq
  _sexybookmarks_permaHash: 370ff92d5aa793f192c0c3a5d603e7d3
---
If you're running servers in the cloud, particularly on Amazon's AWS and haven't heard about <a href="http://www.rightscale.com">RightScale</a> you owe it to yourself to check them out.  I've been using their tools for launching and managing linux servers on AWS.  They allow you to automate all of the tasks to launch a new box, and even run regular operational tasks, all with the use of RightScripts.

RightScripts are just glorified shell scripts which get downloaded from RightScale to your linux server running in any of the clouds they support, and executed with the parameters that you specify in the RightScale dashboard for that RightScript.  Of course, as you start to get into more complex scenarios you're likely to start writing and testing your scripts locally before saving them in the RightScale dashboard.  That's where RightScriptDiff comes in.
<!--more-->

The only way to create or edit a RightScript as of this writing is through the RightScale dashboard.  So you're typing your script into a nice big textarea, where you can't tab for indents or any of the other benefits you get from an editor like vim, emacs, or even *gasp* notepad.exe.  As a result I started to write, and even test my scripts locally before I ever committed them to RightScale.

Going this route of course adds a fair amount of overhead to the process.  You have to remember which scripts you've edited, then copy/paste them into the RightScale dashboard to update the script in their system.  After a while I found I couldn't keep up with the overhead, and I needed to find some good way to compare my local copies of scripts with the ones in my RightScale dashboard.

Thus was born RightScriptDiff.  By supplying RightScriptDiff with your username, password, and account id for RightScale along with a path to a directory containing your local scripts, it will use the RightScale API to compare your local copy against the one stored in your RightScale account.  If you're thinking "why don't you just synchronize the script using the API", you're on the right track.  Sadly, the API doesn't (yet) support RightScripts for anything but viewing, here's hoping they open up that functionality a bit.

In order for RightScriptDiff to compare your local files, they must be named with a specific pattern, namely &lt;rightscript_id&gt;-&lt;rightscript_name&gt;.sh.  Actually, the script name and the *.sh extension are optional, but that's the convention I use so it's easier to identify them.  You can pass (almost) any argument to RightScriptDiff that you can to the "ls" command in *nix and OSX, so something like <em>relative/path/to/RightScripts/*.sh</em> is totally acceptable.  This means you can also target just a single script if you'd like.  RightScriptDiff uses the RightScript_ID section of the filename to look up the script using the RightScript API, then compares the script against your local copy.  If they're the same, you get a happy success message that there is no difference.  If the files are different, a side by side diff is shown.

Here's an example of a successful run;

```
Ryan-Geyers-MacBook-Pro:RightScripts rgeyer$ rsDiff.sh
Please enter the path to scripts stored locally...
*.sh
Grabbing all RightScripts for user: ***** on account: *****.  Be patient, this could take a while...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  369k  100  369k    0     0   148k      0  0:00:02  0:00:02 --:--:--  182k
Found 1 nodes:
-- NODE --

Local copy of 236067-LDAP Install OpenLDAP.sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 237784-LDAP Create Database.sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 237788-LDAP Set Config Admin Details.sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 237789-LDAP Tools Install.sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 238408-LDAP Enable Schema(s).sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 238454-LDAP DB S3 Backup.sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 238480-LDAP DB S3 Restore.sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 238481-LDAP DB S3 Enable Continuous Backup.sh does not differ from RightScale copy.
Found 1 nodes:
-- NODE --

Local copy of 238497-LDAP DB S3 Disable Continuous Backup.sh does not differ from RightScale copy.
```


This is what it looks like when the scripts differ;

```
Ryan-Geyers-MacBook-Pro:RightScripts rgeyer$ rsDiff.sh
Please enter the path to scripts stored locally...
237784*.sh
Grabbing all RightScripts for user: ***** on account: *****.  Be patient, this could take a while...
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  369k  100  369k    0     0   172k      0  0:00:02  0:00:02 --:--:--  220k
Found 1 nodes:
-- NODE --

Local copy of 237784-LDAP Create Database.sh differs from RightScale copy.. Diff below..
							      &gt;	sed -i &quot;s/@@DATABASE_TYPE@@/$DATABASE_TYPE/g&quot; $tmp_file
							      &gt;	sed -i &quot;s/@@DB_CHECKPOINT@@/$DB_CHECKPOINT/g&quot; $tmp_file
							      &lt;
echo &quot;Finishing up...&quot;
```


As mentioned above RightScriptDiff requires three values, your RightScale account email address, password, and account number.  You might notice that in both instances above I did not need to provide them and was prompted only for the path to my scripts.  This is because I pre-defined my credentials and account before hand.   There are a couple ways to provide this to RightScriptDiff, you can call rsDiff.sh with parameters (-e|--email=)&lt;email-address&gt; (-p|--password=)&lt;password&gt; (-a|--account_id=)&lt;account_id&gt;, or you can rename the supplied rsDiffAuth.sh.example file, to rsDiffAuth.sh and put your credentials in there.

After developing this, I discovered that I had edited one of my script files locally and the change wasn't reflected in my RightScale dashboard, so it's already proved useful to me.  Hopefully this helps some other sysadmins building our their RightScale managed clouds.

You can download RightScriptDiff by running the following command.  I wrote it on OSX 10.6.4, but it should work on most flavors of linux as well.

```
svn export https://linode.nslms.com/svn_ro/RightScriptDiff/
```


<em><strong><span style="color: #ff0000;">* UPDATE: RightScriptDiff has a new home</span></strong></em>

```
git clone git://github.com/rgeyer/RightScriptDiff.git
```


Chances are pretty good I'll create a landing page for this, particularly if it becomes popular, so stay tuned here for updates!
