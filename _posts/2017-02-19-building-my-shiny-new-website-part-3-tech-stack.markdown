---
layout: post
title: 'Building My Shiny New Website Part 3: Tech Stack'
date: '2017-02-19 22:40:08'
tags:
- blogger
- hacker
---

This will be my last post on building the new implementation of this site. Having previously talked about the choice of [platform] and the [theme], I’m now going on a quick dive into all of the other tech which keeps the site running the way I like it.  

[platform]: http://harveynick.com/2016/10/16/building-my-shiny-new-website-part-1-platform/
[theme]: http://harveynick.com/2017/01/15/building-my-shiny-new-website-part-2-theme/

Excitingly (for me), this means I get to make diagrams. Let’s start with this monster, which covers every element in the tech stack (or at least every element I can think of):

<p class="wide">
  <img src="http://images.harveynick.com/2017-02-19-building-my-shiny-new-website-part-3-tech-stack_complete.jpg">
</p>

Now that looks cool and all, and was a lot of fun[^1] to make, but it’s a little overwhelming to look at, and isn’t so great to use as a reference when explaining things in words. With that in mind, let’s break it down into three segments. 

## Naming

The first part of the puzzle is what I’m choosing to call “naming”, which encompasses everything related to the actual domain name `harveynick.com`. 

![](http://images.harveynick.com/2017-02-19-building-my-shiny-new-website-part-3-tech-stack_naming.jpg)

The first step here is the registrar. This is the company from which you actually buy and register your domain name. Originally I used [GoDaddy] for this purpose, but around the time [SOPA] was happening it came to my attention that they really weren’t the sort of company I wanted to be doing business with[^2]. I found out about [Gandi.net], whose corporate ethics are much sounder. As an extra benefit: they’re based in France rather than the United States, so I feel like my data is a little safer.

[GoDaddy]: https://en.wikipedia.org/wiki/GoDaddy
[SOPA]: https://en.wikipedia.org/wiki/Stop_Online_Piracy_Act
[Gandi.net]: https://www.gandi.net

Gandi actually provide their own [DNS] service, so under most normal site hosting circumstances I wouldn’t actually need the CloudFlare / DNS block which comes next. However, because the this site is a naked domain (i.e. it’s `harveynick.com` and not `www.harveynick.com`) there’s a slight incompatibility between Gandi and Ghost.io, who host my actual site (as [previously mentioned]).

[DNS]: https://en.wikipedia.org/wiki/Domain_Name_System
[previously mentioned]: http://harveynick.com/2016/10/16/building-my-shiny-new-website-part-1-platform/

The suggested solution is to use [CloudFlare], who support a few advanced DNS options. They also provide some extra features, such as [DDOS] protection and caching. The latter means that (for static content, which this site is) not all requests hit your actual backend. As a result: repeated calls to the same page are faster and your site will appear to stay up even if your backend goes down. That’s really the tip of the iceberg, they offer a lot of other features, many of them for free.

[CloudFlare]: https://www.cloudflare.com
[DDOS]: https://en.wikipedia.org/wiki/Denial-of-service_attack

As a side note: one of the features they offer is basic website analytics, without needing to add any javascript to the page. If they added a couple of additional features and released an app I would probably drop Google Analytics.

The next link is a `CNAME` DNS entry to point requests for `harveynick.com` to `harveynick-com.ghost.io`, the actual host of the site. I think you can probably work out what this does. It’s the internet’s equivalent of a signpost, essentially.

Next is a similar `CNAME` pointer for requests to `images.harveynick.com`. Again, you can probably intuit what this is for. Ghost do provide image hosting, but where the images actually go is pretty opaque.

Exporting the database which backs the site is really simple, making it easy for me to very quickly move to a new host if I need to. The images would pose a problem, though.

My solution is to use [RackSpace] for image hosting instead, putting the images in a storage bucket I control. If I move to a new host for the main site no additional work is required for the images. They’ll be exactly where I left them. Likewise: if I change image hosts all I need to do is copy the images over with the same file names and point `images.harveynick.com` at the new location.

This also gives me the option of doing something more advanced in future, such as using a service which automatically serves lower resolution images to mobile and non-retina devices.

[RackSpace]: https://www.rackspace.com

Lastly, there’s an `MX` record which points to [FastMail]. This allows me to use `@harveynick.com` email addresses. It has nothing to do with the hosting of the site at all, but I though it was a useful thing to include in the diagram.

[FastMail]: https://www.fastmail.com

## Serving

The second part of the diagram is related to serving the actual content of the website to you, the people.

<p class="wide">
  <img src="http://images.harveynick.com/2017-02-19-building-my-shiny-new-website-part-3-tech-stack_serving.jpg">
</p>

The site host and image host I’ve already talked about. Uses of `</img>` tags (or `![](…)` in the source markdown) point to the image hosting and, hey presto, the images appear inline with the words. The other two external elements on the page are an `</iFrame>` which contains the Ad at the bottom of the page, provided by [Google AdSense], and some javascript which points to [Google Analytics].

[Google AdSense]: https://www.google.co.uk/adsense/start/#?modal_active=none
[Google Analytics]: https://analytics.google.com

It should be noted that this is the only javascript the site uses, and I would dearly love to drop it. I’ve tweaked everything else I can think of to make the pages load as fast as possible. That externally hosted javascript is the last thing on my hist list. As noted above, if CloudFlare upped their analytics game this would solve the problem completely. It would also give me real analytics, unaffected by content blockers, which would be nice.

Next we have the automation. Ghost (as yet) has no ability to automatically publish new posts to external sites. I solve this by using a fun service called [If This Then That], which provides some pretty clever automation for the web. In this case it watches the [RSS] feed of the site for new articles. When one shows up it's republished to the following places:

[If This Then That]: https://ifttt.com
[RSS]: https://en.wikipedia.org/wiki/RSS

1. My Facebook timeline (for my friends);
2. My [Twitter feed] (for the internet at large);
3. My [LinkedIn profile] (for recruiters to awkwardly reference);
4. The [original WordPress.com location] of this site (which still has some subscribers).

[Twitter feed]: https://twitter.com/harveynick
[LinkedIn profile]: https://uk.linkedin.com/pub/nick-johnson/1b/771/629/
[original WordPress.com location]: https://harveynick.wordpress.com

Native sharing would be a lot cleaner, but this definitely solves the problem.

## Authoring

Finally we have the “authoring” part of the diagram, which is everything I use to actually create and upload content to the site.

![](http://images.harveynick.com/2017-02-19-building-my-shiny-new-website-part-3-tech-stack_authoring.jpg)

The simplest part is at the bottom. I use [iA Writer] to write the posts. It’s a minimal, cross platform, and very well thought out markdown based editor which I adore. It has just enough extra features (word count, reading time estimation, syntax highlighting) to help me get the job done, and almost no settings to fiddle with. My only real feature request is for them to add the sort of deeper semantic analysis that [Hemingway Editor] and similar services offer.

[iA Writer]: https://ia.net/writer/
[Hemingway Editor]: http://www.hemingwayapp.com

I write the posts in markdown, then edit them against the app’s built in preview. Rereading a post in a different font helps me see what I’ve actually written, rather than what I was *trying* to write. Next I copy and paste the content of the post onto Ghost.io (all right, built-in upload to Ghost is another feature request I have, but nothing else has that either). Then I reread it in Ghost’s editor and fix any stupid mistakes I missed on the previous pass. Then I read it again in Ghost’s preview and… well, you get the point.

If the images in a post are photos I reframe them as needed and maybe add a filter. Then I size them (1280px wide for standard images and 1920px for wide ones, making them retina quality for devices which support it). If they’re diagrams (like the ones in this post) I generally build them in the phenomenal [OmniGraffle] and export them to jpeg.

[OmniGraffle]: https://www.omnigroup.com/omnigraffle

Next I run them through [JPEGmini] and then [ImageOptim]. These reduce the size of the images without visibly lowering their quality. Between the two of them, the size of the images is generally reduced by at least 33% (sometimes a *lot* more), although this very much depends on the image. ImageOptim is free software, where as JPEGmini is commercial. It has a free “Lite” version which is good for 20 images a day, though.

[JPEGmini]: http://www.jpegmini.com
[ImageOptim]: https://imageoptim.com

Lastly I use the [DropShare] widget to upload the images to RackSpace. This is neat little program which gives you four or so upload methods (sharing extension, system service, status bar widget and good old file picker) and drops a fully qualified path to the uploaded image onto the pasteboard when it’s done. A quick `CMD+V` in the right spot of your doc and you’re ready to go.

[DropShare]: https://getdropsha.re

[^1]: Yes. Fun. I like making diagrams, okay?

[^2]: Seriously. Check out that list of controversies on the wikipedia article, and they don’t even cover the company's historical advertising… strategies.
