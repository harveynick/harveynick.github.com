---
layout: post
title: 'Building my Shiny New Website Part 1: Platform'
date: '2016-10-16 10:36:30'
tags:
- blogger
---

This is a post which has been a long time coming. I’ve been planning it since I started *building* the new version of this site, which is ~~coming up on~~ over a year ago now. Step one was to choose the platform.

Having used [Wordpress] before, I knew I didn’t want to use it again. Whilst “old, popular and boring” is probably a pretty good metric for what you should use when it comes to any sort of backend technology, Wordpress feels like the past. At this point it’s an unfocussed and generic website engine, and a mess internally to boot.

[Wordpress]: https://wordpress.org

I also didn’t want to use [Jekyll] or [Octopress]. I love the flat file approach; the fact that the files on disk are one master version of the content and converted directly into the source of the site. If (or let’s face it: when) I find a typo or dumb grammar mistake later there’s only one place to fix it. But this also introduces a cost: A git push is required to update the site, which removes a lot of flexibility. Updating on the fly is possible, but a lot harder. Scheduling posts is essentially not possible. The extra legwork required to actually create a new post also turns out to be a blocker for me. I can handle work just fine, but faff trips me up every time.

[Jekyll]: https://jekyllrb.com
[Octopress]: http://octopress.org

I use [Tumblr] for my short film review blog, so that was also an option. Posts can be authored in markdown syntax, and post scheduling is available. Both of those sound good… except the actual implementation of both is pretty terrible. The last time I tried it, Tumblr’s markdown parser seemed to missing a few features and would silently fail for some things. The theming functionality is also seriously ropey, and requires dumping everything into a single file. At the end of the day Tumblr is aimed mostly at short posts. It’s Twitter with bells on.

[Tumblr]: https://www.tumblr.com

Tumblr is very convenient and has a large (if somewhat toxic) community attached to it, but seems to score a negative in just about every other metric. Add to this the fact that Yahoo! seems to have absolutely no idea what to do with it, and the platform seems to be floundering somewhat.

I considered [Squarespace] pretty hard as well. Everyone who uses it seems to love it. It is, however, completely proprietary and not exactly cheap. It’s also a website platform rather than a blogging platform, and I’d prefer to use something with a narrow focus.

[Squarespace]: https://www.squarespace.com

[Medium.com] is a pretty big name in the online publishing world at the moment. It has a large community and the network effects which go along with it. They also seem to have a pretty good handle on that aspect: their moderation tools are excellent and the community is decidedly less toxic than that of Tumblr. Medium is free to use, even with a custom domain, but only very limited visual customisation is possible. Medium based publications look absolutely fantastic, but if Medium as a whole makes a change it also applies to your work whether you like it or not.

It’s a bit of a double edged sword in a lot of ways. Your writing can potentially appear beneath that of others, expanding your reach. But the writing of others will also appear beneath your posts, making them feel less “yours”. Medium doesn’t support markdown directly, but does support upload of content written in markdown and its web based WYSIWYG writing environment is *fantastic*. However, it’s missing some formatting options:

* Footnotes;
* Strikethrough;
* Superscript and subscript;
* Monospace.

[Medium.com]: https://medium.com

That last one means that it’s a complete non-starter for this blog. I like to talk about coding and a monospace font is a *must* for that.

I also looked at a whole bunch of solutions which are backed by a DropBox folder or an Evernote notebook. On the surface these sound like great ideas. Being able to drop the relevant markdown files into a DropBox folder and this magically becoming a website sounds pretty ideal. Unfortunately I couldn’t find one of these options which I was confident would still be around in a year.

Which brings me to [Ghost]. It was originally envisioned as a fork of WordPress designed to take it back to its roots as a dedicated blogging platform. This turned out to be an unworkable solution and so become a greenfield project starting again from scratch. The intent is to build “the perfect blogging platform”, which sounds like exactly the sort of thing I was looking for. It’s also completely open source. This means the options for using it are pretty wide open. I can move freely between hosts which support it, and even set it up on my own server if it comes right down to it. It’s also not implemented in PHP (yay!), but instead uses [node.js] (boo!). Okay, that’s a little unfair. There are definitely advantages to the front and back end being written in the same language. That said: I would prefer that it was written in [Go] or [Swift]. Or even [Ruby].

[Ghost]: https://ghost.org
[node.js]: https://nodejs.org
[Go]: https://golang.org
[Swift]: https://developer.apple.com/swift/
[Ruby]: http://www.ruby-lang.org

Posts are written directly in markdown and stored that way in the database. It has complete markdown support, plus some extra things such as footnotes. Plus it has a pretty great web based markdown editor. It also has solid theming support. There are a lot of free and paid themes available, and copious documentation available should I want to make my own. Also: as of right now it supports scheduling posts.

The main downside is that it hasn’t yet hit the 1.o milestone. But what the hell. Nothing ventured; nothing gained.

Final note: I’m hosting with Ghost themselves. It’s not super cheap, but it means that updates happen automatically behind the scenes. Also: it means I’m making a direct financial contribution to a project I want to advance.