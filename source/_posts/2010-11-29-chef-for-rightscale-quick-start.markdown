---
layout: post
title: Chef for RightScale Quick Start
comments: true
categories:
- Cloud computing
tags:
- chef
- cloud
- configuration
- cookbooks
- linkedin
- RightScale
- script
status: publish
type: post
published: true
meta:
  _edit_last: '1'
  _syntaxhighlighter_encoded: '1'
  _sexybookmarks_shortUrl: http://b2l.me/a7r6vq
  _sexybookmarks_permaHash: 4f3fcd9289e1ad70de0ee9a344598ab8
  _headspace_description: ''
  _headspace_page_title: ''
comments: true
  Hide OgTags: '0'
  Hide SexyBookmarks: '0'
---
For the past few weeks I have been getting down and dirty writing Chef recipes for use in RightScale.

With Chef support still in beta on RightScale, and me being a complete Chef newbie it's I'm still on the front side of the learning curve.

If you're just getting started with Chef for RightScale, you might benefit from this quick start and some of the lessons I learned while getting started.

<h1>Mise en place</h1>
While you could just open up Notepad or TextEdit and start writing your Chef recipes, there are a few resources that will make the experience much more enjoyable.

<h2>Install Chef</h2>
The first thing you're going to want to do is install the Chef Ruby Gem.  This will add all of the libraries and binaries for Chef.

While we're writing our recipes for use with RightScale we won't need to worry about using the Chef Server, Chef Solo, or Chef Client, so don't bother configuring any of those.

I'm developing on a Mac and the only suitable installation method seems to be using Ruby Gems to install.  This mechanism should also work for most Linux and Debian machines which already have Ruby installed.

```
sudo gem install chef
```


Be sure that you run this as root, or with sudo or Chef will get installed at ~/.gem and won't be in your $PATH or consequently accessible to other users.

<h2>Sharpen your knives</h2>
Now that you have all of the Chef goodies installed, you'll have a binary named "knife".  The knife is a utility which we'll be using as we develop our cookbooks and recipes which you'll see later.

First though, we need to configure knife.  Since we'll only be using knife to act locally on our recipes and cookbooks we don't need to give it legit values for a Chef server, but we do need to complete the configuration step to satisfy knife and prevent it from crashing when we use it.

To create a simple configuration file for knife, just run knife config, and accept all of the defaults.

```
knife configure
No knife configuration file found
Where should I put the config file? [~/.chef/knife.rb] 
Please enter the chef server URL: [http://localhost:4000] 
Please enter an existing username or clientname for the API: [rgeyer] 
Please enter the validation clientname: [chef-validator] 
Please enter the location of the validation key: [/etc/chef/validation.pem] 
Please enter the path to a chef repository (or leave blank): 
WARN: *****
WARN: 
WARN: You must place your client key in:
WARN:   /Users/rgeyer/.chef/rgeyer.pem
WARN: Before running commands with Knife!
WARN: 
WARN: *****
WARN: 
WARN: You must place your validation key in:
WARN:   /etc/chef/validation.pem
WARN: Before generating instance data with Knife!
WARN: 
WARN: *****
WARN: Configuration file written to /Users/rgeyer/.chef/knife.rb
```


You're safe to ignore the warnings since they only pertain to actually connecting to a Chef server, which we won't be doing.

That's it for installing and configuring Chef if you're using it with RightScale!

<h2>Prepare your pantry</h2>
Once you get going with Chef you're going to need to store your cookbooks somewhere for RightScale to find them and run them.

RightScale will use svn or git repositories, as well as simply downloading a tar or zip file, but my personal preference is to use a git repository.

The quickest and easiest way to get started with git is to head over to <a href="https://github.com/">github</a> and sign up for a free account.

Once you're setup, go ahead and create the repository we'll be using for our Chef cookbooks, and note the SSH URL to your new repository.  It should look something like <em>git@github.com:&lt;github_username&gt;/&lt;repo_name&gt;.git</em>.  Write it down or keep the browser window open so you can reference it later.

<h1>Heat things up</h1>
Now that you've got your <a href="http://en.wikipedia.org/wiki/Mise_en_place">mise en place</a> it's time to get cooking for RightScale with Chef.

<h2>Create your repo</h2>
The first step is to get the file structure of your Chef repository setup.  You could just take a look at an existing repository like the <a href="https://github.com/opscode/cookbooks">opscode</a> cookbooks, or RightScale's <a href="https://github.com/rightscale/cookbooks_public">public repository</a> and replicate it manually, but there is a better way.

<h2>Clone the OpsCode repo</h2>
OpsCode, (the folks behind Chef) have conveniently provided a public github repository that represents the skeleton of a fully operational Chef repository.  You can clone this repository to get you started.

```
git clone git://github.com/opscode/chef-repo.git
```


Once you've cloned the skeleton repository, you'll want to configure git to use the new github repository we created earlier.  Here's where you'll use the SSH URL I told you to take note of.  Substitute that URL where you find &lt;ssh_url&gt; below.

```
cd chef-repo/
git remote rename origin opscode-github
git remote add origin &lt;ssh_url&gt;
git remote rm opscode-github
git push origin master
```


<h2>Create cookbook</h2>
With the repository skeleton all ready, we're going to want to create our first cookbook and add a recipe to it.

Creating a cookbook is our first chance to use our freshly sharpened knife, like so.

```
knife cookbook create my-first-cookbook -o cookbooks/
```


This should create a nice new cookbook skeleton directory at &lt;path_to_your_repo&gt;/cookbooks/my-first-cookbook.

With that done, let's put our first recipe in the cookbook.  Using your favorite IDE, create and save a file named <em>helloworld.rb</em> inside the new cookbook directory.

<strong>EDIT: Many have correctly pointed out that the hello world file should actually go in <em>&lt;path_to_your_repo&gt;/cookbooks/my-first-cookbook/recipes</em>.  Thanks all for the feedback!</strong>

{% codeblock helloworld.rb lang:ruby %}
log "Hello World"
{% endcodeblock %}


With the recipe created, we need to add it to our metadata file so that Chef and RightScale can know it's there.  Here's a copy of our default <em>metadata.rb</em> file.  The highlighted line is added to define the recipe we've added.

{% codeblock metadata.rb lang:ruby mark:8 %}
maintainer       "YOUR_COMPANY_NAME"
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures my-first-cookbook"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "0.0.1"

recipe "my-first-cookbook::helloworld", "My first recipe, prints Hello World to the RightScale dashboard"
{% endcodeblock %}


We only have one more step before we're ready to commit our new cookbook and recipe to our new git repository.

RightScale reads the metadata to determine which recipes are available in the repository, and which inputs are available for those recipes.  The file that RightScale evaluates though is a json file named <em>metadata.json</em>.

The contents of <em>metadata.json</em> are effectively the same as <em>metadata.rb</em>, but take heart, you only need maintain the <em>metadata.rb</em> file, then convert it using another Chef command.  To generate <em>metadata.json</em> from <em>metadata.rb</em> just run the following command.

```
rake metadata
```


You can run this command either right at the root of your repository, or inside each cookbook.  If you run it from the root directory of your repository, it will convert all the metadata files in all of the cookbooks.

Now we're ready to commit our repository and try out our new cookbook.

```
git add cookbooks/
git commit -am &quot;Added my-first-cookbook and helloworld recipe&quot;
git push
```


<h1>RightScale Configuration</h1>
I'm going to assume that you already have some familiarity with the RightScale dashboard, and creating things like ServerTemplates and RightScripts.

What I'm going to cover here are steps are necessary to start using Chef with your ServerTemplates.

<h2>Tell RightScale about your Repo</h2>
The first thing you need to start using your cookbooks in RightScale is to tell the RightScale dashboard where to find your repo.  To do that, you need to create a new <em>RepoPath</em> in the designer.

<a href="http://www.flickr.com/photos/rgeyer/5216898582/" title="Screen shot 2010-11-28 at 7.33.05 PM by qwikrex, on Flickr"><img src="http://farm6.static.flickr.com/5128/5216898582_2c0d17f8d8_z.jpg" width="640" height="359" alt="Screen shot 2010-11-28 at 7.33.05 PM" /></a>

<a href="http://www.flickr.com/photos/rgeyer/5216898726/" title="Screen shot 2010-11-28 at 7.33.35 PM by qwikrex, on Flickr"><img src="http://farm6.static.flickr.com/5205/5216898726_cbc1351324_z.jpg" width="640" height="359" alt="Screen shot 2010-11-28 at 7.33.35 PM" /></a>

When you're adding the RepoPath, for the URL field, supply the "Git Read-Only URL" for your repository, and make sure to specify the path to your cookbooks as <em>cookbooks</em>.

<a href="http://www.flickr.com/photos/rgeyer/5216310951/" title="Screen shot 2010-11-28 at 7.34.37 PM by qwikrex, on Flickr"><img src="http://farm5.static.flickr.com/4104/5216310951_0400b36fd8_z.jpg" width="640" height="440" alt="Screen shot 2010-11-28 at 7.34.37 PM" /></a>

<h2>Add your RepoPath to a ServerTemplate</h2>
Now that you've added your repo to the RightScale dashboard, you need to add that RepoPath to a ServerTemplate.  To do that, open the ServerTemplate you want to run Chef cookbooks on, and click the edit pencil on the <em>Repos</em> tab.

Then select the RepoPath we just made, and click OK.

<a href="http://www.flickr.com/photos/rgeyer/5216937566/" title="Screen shot 2010-11-28 at 7.56.33 PM by qwikrex, on Flickr"><img src="http://farm6.static.flickr.com/5128/5216937566_30f703fb4b_z.jpg" width="640" height="440" alt="Screen shot 2010-11-28 at 7.56.33 PM" /></a>

<h2>Add a recipe to your ServerTemplate</h2>
Our very last step is to add our helloworld recipe to a our ServerTemplate so that we can run it on one of our instances.  Go back to the <em>Scripts</em> tab, and in the script category of your choosing, click <em>Add Recipe</em> and select the helloworld recipe.

<a href="http://www.flickr.com/photos/rgeyer/5216369965/" title="Screen shot 2010-11-28 at 8.02.27 PM by qwikrex, on Flickr"><img src="http://farm5.static.flickr.com/4083/5216369965_469cafb59b_z.jpg" width="640" height="440" alt="Screen shot 2010-11-28 at 8.02.27 PM" /></a>

<a href="http://www.flickr.com/photos/rgeyer/5216958398/" title="Screen shot 2010-11-28 at 8.02.34 PM by qwikrex, on Flickr"><img src="http://farm6.static.flickr.com/5127/5216958398_b087c4abb2_z.jpg" width="640" height="440" alt="Screen shot 2010-11-28 at 8.02.34 PM" /></a>

From an instance running with the ServerTemplate we just modified, we can run the recipe, and see "Hello World" appear in the RightScale dashboard.

<a href="http://www.flickr.com/photos/rgeyer/5216405207/" title="Screen shot 2010-11-28 at 8.18.58 PM by qwikrex, on Flickr"><img src="http://farm5.static.flickr.com/4088/5216405207_bfa688f098_z.jpg" width="640" height="440" alt="Screen shot 2010-11-28 at 8.18.58 PM" /></a>

<h1>Tips & Tricks</h1>
As stated before, Chef support in RightScale is still in Beta.  Because of this there are some gotchas to watch out for.

<h2>Sanity Check Recipe</h2>
If there are any syntax errors or anything else amiss in your repository, you'll find that not just the cookbook or recipe which you're working on is failing, but absolutely <strong><em>every</em></strong> recipe in your repo (or any other repo that's part of your RepoPath) will fail with this super informative error message.

```
*ERROR&gt; Chef process failed with return code 1
```


Of course, you can also get that error message if you have some other problem in the recipe you're working on.

Because of this I find it useful to keep a "smoke test" recipe in my repo, and assigned to the operational scripts on my ServerTemplate when I'm doing Chef development.  This recipe should be something simple that you know will always succeed, assuming that everything else is in order.

The helloworld recipe that we created in this exercise is actually a perfect choice for this purpose.

<h1>Taste Test</h1>
So there it is, everything you need to know to get started using Chef on RightScale condensed from my few weeks of experience.  I hope it helps you get started configuring your server instances with Chef, which brings a whole new dimension of power and flexibility to the RightScale ServerTemplates.

I'm excited to see how Chef support progresses and makes it to <em>production</em> status.

If you're hungry for more info, check out some of the early documentation available about using Chef in RightScale <a href="http://support.rightscale.com/index.php?title=09-Clouds/Multi_Cloud/Chef">here</a>.
