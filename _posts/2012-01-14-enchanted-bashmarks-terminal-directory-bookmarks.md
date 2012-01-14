---
layout: post
title: Enchanted Bashmarks - terminal directory bookmarks
date: 2012-01-14 00:57:33
category: Unix
tags:
 - Bash
 - Scripting
description: Bashmarks is a shell script that allows you to save and jump to commonly used directories.
---

[Bashmarks](/projects/bashmarks "Bashmarks project page") is a shell script that allows you to save and jump to commonly used directories.

Usage Example
-------------

{% highlight bash tabsize=2%}
$ cd ~/home/projects/www/
$ s web
$ cd /usr/local/lib/
$ s locallib
$ l
web          /var/www/
locallib     /usr/local/lib/
$ g w<tab>
$ g web           # cd to ~/home/projects/www/
$ g l<tab>
$ g locallib      # cd to /usr/local/lib/

{% endhighlight %}


Extra Features
--------------
* if no bookmark name is specified the default directory is used instead  ($HOME unless changed)

{% highlight bash tabsize=2 %}
cd ~/projects
s
g              # g now defaults to ~/projects 
{% endhighlight %}


* Commands can be placed after the bookmark  
{% highlight bash tabsize=2 %}
$ g web ls     # cd to ~/home/projects/www/ then executes ls 
~/var/www/
index.html
site.css
$ 
{% endhighlight %}

* cd like features 

{% highlight bash tabsize=2 %}
g -   # does cd -
g ..  # does cd ..
g /   # does cd /
{% endhighlight %}


### Mac Specific Features ###
* `o` command which opens the specified bookmark in Finder
* `t` command which opens the specified bookmark in a new Terminal tab.

{% highlight bash tabsize=2 %}
t web          # opens ~/home/projects/www/  in a new tab
cd javascript 
t              # opens ~/home/projects/www/javascript in a new tab

o              # opens ~/home/projects/www/javascript in Finder
{% endhighlight %}


Install
-------
1. git clone git://github.com/Bilalh/bashmarks.git
2. make install
3. **source ~/.local/bin/bashmarks.sh** from within your **~.bash\_profile** or **~/.bashrc**

OR 
 
download [https://github.com/Bilalh/bashmarks/blob/master/bashmarks.sh](https://github.com/Bilalh/bashmarks/blob/master/bashmarks.sh) and source it from within your **~.bash\_profile** or **~/.bashrc**


More Information
---------------
See the [Project Page](/projects/bashmarks "Bashmarks project page") for information.  
[GitHub Repository](https://github.com/Bilalh/bashmarks "Bashmarks GitHub Repository")