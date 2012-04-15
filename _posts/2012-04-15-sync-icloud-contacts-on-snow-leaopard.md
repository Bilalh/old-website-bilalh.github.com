---
layout: post
title: Sync iCloud Calendars on Snow Leaopard
date: 2012-04-15 04:50:10
category: OSX
tags:
 - Utilities
 - iCal
---

Syncing iCloud's Calendars on Snow Leopard is quite simple. The only information that requirement is your **iCloud Server Number** which nearly always in the form **pXX-caldav.icloud.com**.

To find this number open Safari and [login to your iCloud](http://icloud.com/) account. 

Click on Calendar and then chose **Windows —> Activity** from menu bar.

In the window you should see something that is similar to this:

{% highlight tabsize=2 %}
p01-contactsws.icloud.com/co/mecard/?dsid=1325673149
{% endhighlight %}

The **iCloud Server Number** is the first part of the address namely **p01** in this case.


Syncing iCal
------------

Open iCal's Preferences, then pick the **Accounts Tab**. Click the plus sign at the bottom left. 

Fill in the fields with the following settings:

|Field|Value
|:-------|:---|
|Account Type:  | CalDAV
|User name:     | yourUserName@me.com
|Password:      | yourPassword
|Server Address | pXX-caldav.icloud.com

pXX is your **iCloud Server Number** from above.

Now click create create. If it asks you to pick a server choose pXX-caldav.icloud.com  from the above settings.

It should work now!
