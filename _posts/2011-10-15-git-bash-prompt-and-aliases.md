---
layout: post
title: git bash prompt and aliases
date: 2011-10-15 22:37:32
category: Unix
tags:
 - Git
 - 
---

You can get git to shown the information such as which branch you are on by using the following:

{% highlight bash tabsize=2 %}
export PS1='\u$(__git_ps1 "@%s") \$ '
{% endhighlight %}

This would as display as `User@master $ `.  You can git to shown even more information by using the following.
 
{% highlight bash tabsize=2 %}
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
{% endhighlight %}

* `GIT_PS1_SHOWDIRTYSTATE` adds a `*` at the end if the branch has been changed e.g `User@master * $ `
* `GIT_PS1_SHOWUNTRACKEDFILES` adds a `%` at end if the branch has untracked files e.g `User@master % $ `
* `GIT_PS1_SHOWSTASHSTATE` shows a  if the stash contains anything.
* `+` at the end means that there are changed to be committed.

For a full colour prompt use 

{% highlight bash tabsize=2 %}
export PS1='\[$(tput setaf 3)\]\u\[$(tput sgr0)$(tput setaf 5)\]\[$(tput sgr0)$(tput setaf 2)\]$(__git_ps1 " [%s]") \[$(tput sgr0)\]$ '
{% endhighlight %}

which shows `bilalh [mediakeys] $` but in colour

This has been tested with `git version 1.7.3.4` but should work with 1.6.5+ and requires git `bash_completion`, see [git bash completion](https://github.com/markgandolfo/git-bash-completion, "git bash_completion") if you don't have it.