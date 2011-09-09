---
layout: post
title: Git Delete Last Commit
date: 2011-09-09 20:36:06
category: Unix
tags:
 - Git
 - 
---

If you have committed files that you shouldn't have (e.g passwords, keys) you can use the following to delete the last commit provided the commit has not been pushed. 

{% highlight bash tabsize=2 %}
git reset --hard HEAD~1
{% endhighlight %}

`Head~1` means the pervious commit, you can also use the SHA-1 of commit to **delete** all commits back to that commit.  

>   Note that `--hard` get rid of **any** changes from the deleted commit(s). Use `--soft` to leave the files as `Changes to be committed`.

If you have pushed the commit then you can do 

{% highlight bash tabsize=2 %}
git revert HEAD
{% endhighlight %}

which creates a **new** commit that get gets rid of all the changes in the last commit.