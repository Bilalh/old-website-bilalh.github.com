---
layout: post
title: Pipe output from command line tools to a text editor
date: 2012-04-22 22:01:23
category: OSX
tags:
 - Scripting
 - Utilities
---

A useful feature is to pipe the result of a command such as `ls` to a text editor. This can be done by using:

{% highlight bash tabsize=2 %}
	ls | open -f
{% endhighlight %}


Using the `-a` flag for `open`  makes this even more useful allowing you to specify the application to open the output in e.g to  open in TextMate use

{% highlight bash tabsize=2 %}
	ls | open -f -a Textmate
{% endhighlight %}

 