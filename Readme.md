bilalh.github.com {#readmeTitle}
=================
Personal Website and project pages
{#description}


Prerequisites
-------------
* Ruby (only tested with 1.9)

	gem install nokogiri sass growl

Install 
-------
* `mkdir _cache _compiled _site`
* git clone in `_compiled`  -- this pushes to master 
* Check out the `source` branch  


Rakefile
--------
* `rake build` builds  the website.
* `rake ` or `rake local` builds the site and opens it in firefox.
* `rake send` pushes the compiled version to github.
* `rake ssend` pushes the compiled version to github, after deleted the `cache`.
* `rake new <title>` makes a new blog post using `<title>` and the current date.


Options
-------
* see config.yml

Issues
------
None Yet

Licence
-------
[Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License](http://creativecommons.org/licenses/by-nc-sa/3.0/ "Full details")

Authors
-------
* Bilal Syed Hussain