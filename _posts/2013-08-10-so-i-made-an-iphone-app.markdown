---
layout: post
title: So I made an iPhone App
date: '2013-08-10 12:11:00'
tags:
- hacker
---

Various things have kept me busy and away from this blog just recently. I've done a bit of traveling (both for business and pleasure), I've discovered Netflix (and Crunchyroll), and, somewhat more productively, I followed through on what started off as my "20% time" project.

There is, [right now in the iPhone App Store], an app nominally _by Google Inc_ which was written almost entirely by my own good hands. Obviously I wasn't entirely a one man band in this. I had a lot of help from designers and UX people, my code was reviewed by those who were available to do so, and I had support at the product management level. I also had a very understanding manager who was willing to let me devote an increasing amount of my time to this.

[right now in the iPhone App Store]: https://itunes.apple.com/app/id680739529?mt=8

<!-- More -->

The app itself is, at this point, very simple. It provides a basic overview of an AdSense account, together with couple of other reports. It looks a little bit like this, in fact:


![](http://images.harveynick.com/2013-08-10-so-i-made-an-iphone-app-screen568x568.jpeg) 


Actually getting to a place where I could get such a simple app published was not itself such a simple process, however.

First of all I had to learn a new programming language. I'm not a complete stranger to Objective-C, [I wrote about it before] in fact, but there was definitely a learning process involved. Objective-C is a bit of a strange beast. At times it behaves like C, at other times more like Ruby. It can be forgiving at times, while at others it will explode in your face without warning or explanation.

[I wrote about it before]: /2010/10/11/youre-speaking-my-language-baby-part-4-objective-c

Things which are considered fairly normal in Objective-C would be considered completely insane in most other programming languages. It's also very, very verbose. Your method calls can quite easily stretch over eight lines. I keep joking that learning Objective-C decreased my ability to communicate in English. Too many languages in one head. At least I think I'm joking...

I also had to learn a new platform and set of tools. UIKit is, in my opinion, a brilliant framework. As soon as you start adding something like [NimbusKit] into the mix you're working with really powerful tools which let you put together beautiful and incredibly smooth applications in a very natural manner. XCode, though, took a little bit of getting used to. Likewise, many of the standard build tools I'm used to working with at Google simply weren't available to me.

[NimbusKit]: http://nimbuskit.info/

Once the app was built and tested, tweaked and ready, the next step came. The one iPhone developers seem to dread. Submitting the app to Apple for review. In my case this was fairly straight forward (if complicated by the Apple developer site's recent downtime). The iTunes connect interface gets the job done quite well. There were no weird problems and no stonewalling.

So there you have it. I'm officially an iOS developer. I enjoyed this and I plan to keep doing it. If you're an AdSense user and carry an iPhone, I encourage you to [install the app] and send me feedback. If you carry an Android phone, on the other hand, I encourage you to download [the equivalent Android app], developed by my colleague Agnieszka.

[install the app]: https://itunes.apple.com/app/id680739529?mt=8
[the equivalent Android app]: https://play.google.com/store/apps/details?id=com.google.android.apps.ads.publisher