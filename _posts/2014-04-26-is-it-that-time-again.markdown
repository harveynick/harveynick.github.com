---
layout: post
title: Is it Time to Change Blogs Again?
date: '2014-04-26 22:48:00'
tags:
- blogger
---

So you may have noticed that it's been a little quiet around here as of late. There are a few reasons for this. Firstly, I've been stupidly busy with work and the amount of... faff involved with adding a new post using [Octopress] has been something of a blocker.

[Octopress]: http://octopress.org

You see, Octopress Isn't like Wordpress or Blogger. It doesn't run on a server out there in the cloud. It's a program and a set of files on your local machine. You create new posts as text files, then run the program. This generates a set of HTML files, which you then upload to a server. In some ways this is a lot closer to programming than regular writing.

So when I upgraded my computer it was more than a small amount of effort to reassemble all of the different components required for this. It took me a while to work up the enthusiasm. Plus: not everything worked. Hence the fact that I'm back on the default theme.

So, I got to thinking... perhaps it's time to look at other options. Again.

<!-- More -->

With this in mind I came up with a list. Who doesn't like lists? I want to:

- Write posts in markdown format. WYSIWYG editors end up being more trouble than they're worth, sooner or later;
- Own my posts. That is: I want them to be stored in a place I can see and access, not hidden away in a database;
- Be able to preview the final appearance of a post;
- Have good options for analytics. Given that I wrote [AdSense for iPhone], it would be nice if AdSense was one of those options;
- Not have to pay the earth. I'm not adverse to paying here... but I'm not going to pay a lot;
- Be able to easily edit a post on the go. For example: If I notice a spelling or grammar error (or someone points one out to me);
- Have a minimum of faff involved in in creating and publishing a post;
- Have a clean, responsive and flexible design;
- Make it really easy to include an image as part of a post, or use one as a header image;
- Be able to time the publication of a post.

[AdSense for iPhone]: https://itunes.apple.com/app/google-adsense/id680739529?mt=8

...and here are the options I'm looking at:

## [Octopress](http://octopress.org)

Basically: keep doing what I'm doing now. The least amount of faff in the short term, but the most in the ongoing sense. It nicely hits the first five points above, storing all posts as text files in a git repository and allowing you to view a local version of the site, but misses on just about all of the others.

In particular: if I have Internet access, I can change the site. But if I'm not at a computer with the entire environment set up it's a faily annoying process, since I have to make any change in two places: the HTML and the source file.

## [Jekyll](http://jekyllrb.com)

You could call this diet Octopress, though actually Octopress is built on top of Jekyll. If you use this and host it on GitHub Pages (which is what I'm already doing) some of the headaches I have with Octopress go away, namely: the need to manually regenerate the site with any change. But... it's also a lot less powerful. Hosting it in this way does not allow you to use any plug-ins, so some things (such as including a YouTube video as part of a post) become much more annoying.

## Octopress plus... additional magic

This is probably the most hacker like of all of the options here. Thus: the one which is most likely to go horribly, horribly wrong. What I'm talking about here is something like what is described in [this post]. Essentially: I would write the blog and post it to a git repository exactly as I have been doing all along, but rather than it then being published by GitHub Pages, the change would then be picked up by an external system, which would automatically build the website and publish it.

[this post]: https://www.bitballoon.com/2013-12-13-continous-deployments-for-jekyll-sites

Obviously this adds a lot of complication, but also combines the strength of the two options above. I would get the power and flexibility of Octopress, plus any change to the source file would result in the website being updated. GitHub actually allows you to edit a file and commit the change via their site, but this is not the only option. I might also be able to use this approach to time the publishing of posts. Maybe.

## [Tumblr](http://www.tumblr.com)

I'm actually already using for my (also slightly neglected) [short film reviews blog]. It's a really solid hosted blog platform, and the functionality for scheduling posts is absolutely top notch... but it just doesn't feel right for long form writing to me. It feels more like "Twitter with knobs on."

[short film reviews blog]: http://ohsohumbleopinion.tumblr.com

Still, it is worth considering.

## [Postach.io](http://postach.io)

This is an interesting one. The idea is that you write your posts as notes in [Evernote], and then Postach.io picks them up via the Evernote API posts them to your blog. It also seems to have functionality for [pulling posts] out of DrobBox in a similar fashion. In a lot of ways this sounds pretty ideal to me, especially in terms of workflow.

[Evernote]: http://www.evernote.com
[pulling posts]: http://help.postach.io/creating-posts-pages-with-dropbox

See also: [Skrivr], [Calepin] and [Scriptogr.am], all of which I'm going to take a look at.

[Skrivr]: http://skrivr.com
[Calepin]: http://calepin.co
[Scriptogr.am]: http://Scriptogr.am

## [Ghost](https://ghost.org)

Ghost is a very interesting looking blogging platform which emerged from a recent Kickstarter Campaign... and that's about all I know about it so far.

## The Plan

Basically: I'm going to post this entry, another one I've had in mind for a little while, the "Whilst not running in Australia" post and probably one other to a few of these options to find out just how painful it is. Then we'll see.