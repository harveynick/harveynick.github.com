---
layout: post
title: I Ain’t Dead
date: '2018-05-06 21:45:20'
tags:
- blogger
---

I know, it’s been pretty damn quiet around here. Aside of course, from a single [repost](/2018/04/25/some-notes-on-the-andrew-ng-coursera-machine-learning-course/) from my other blog. But I’d like to cite two pieces of evidence to prove that I haven’t been doing nothing at all: 

1. This site has a shiny new theme;
2. I’ve actually been posting multiple times a week over at my [Future Technology](https://ftrsn.net) blog.

Lets talk about the theme first. It’s called [Cedar](https://cedar-ghost.ecko.me), and I paid actual money for it over at [Theme Forest](https://themeforest.net/item/cedar-responsive-ghost-theme/13127587?s_rank=6). Why pay money for a theme, when there are plenty of free ones available? I didn’t like any of the free ones enough, essentially. I tend to believe that the intersection of talent and compensation leads to high quality work. I was pretty happy to pay a fair price for a good design[^1]. 

I know just enough web development to be dangerous and I wrote this site’s previous theme. It was… functional, but I was never completely happy with the design. It also had a bunch of odd CSS issues, and I didn’t relish the thought of updating it if a new major version Ghost brakes compatibility.

As suggested above, this site still runs on [Ghost](https://ghost.org), whereas [ftrsn.net](https://ftrsn.net) is [Wordpress](https://wordpress.org) based. Having used it pretty solidly for a few months, I’d like to talk a little about the things I like about it. Then I’d like to talk about why I have no plans to move this site over to it, and why a future project I’m working on will likely also use Ghost.

One point in Wordpress’ favour is that it’s ubiquitous. What [I said before](/2017/11/06/blogging-on-the-quartz-curve/) is still true now. Getting up and running with Wordpress can be both free and easy[^2].  This ubiquity means that there are plenty of themes available for it, and plugins to do just about anything you might want. I try to run as few plugins as possible on the site, on the basis that any of them could have a security flaw. But still, I currently have eight active plugins:

1. **Disable Comments**. I don’t use them on the site, this makes sure there isn’t even the option to accidentally enable them;
3. **Jetpack by Wordpress**. To add all of the missing features which otherwise would require hosting at [Wordpress.com](https://wordpress.com);
2. **Google Analytics**. To fill in the gaps Jetpack misses, although I am looking at alternatives;
4. **Limit Login Attempts**. For security;
5. **miniOrange**. Adds 2 factor authentication, again for security;
6. **Really Simple SSL**. To force https to be used instead of http when possible;
7. **WP Super Cache**. To try and pretend that Wordpress isn’t painfully slow;
8. **WP to Twitter**. Handles automatic posts to Twitter *much* better than Jetpack.

I also have 2 deactivated plugins which I keep around in order to workaround a few missing capabilities of Wordpress:

1. **Categories to Tags**. Because otherwise I’d need to use database queries(!) to do this;
2. **Post Type Switcher**. As above.

As for themes: Wordpress makes it really easy. If the theme is available on Wordpress’ marketplace, you can install and activate it from the Wordpress console. Any configuration parameters can then be edited from the console as well, with the live UI to show you the changes. You can also also edit the theme files directly, again from the Wordpress console. Don’t do that, though. In the first instance it might break. In the second: when you use Wordpress, your website is a sausage. You do *not* want to see how it gets made. In short, though: You can edit your site *from* your site.

One thing which I have nothing but good things to say about is the workflow I’ve been able to achieve with Wordpress. [Ulysses](https://ulyssesapp.com), my editor of choice, has Wordpress export built in. I can seamlessly move between writing on my laptop and my iPad[^3]. The iPad, when coupled with a smart keyboard, turns out to be an absolutely spectacular machine for this. It’s light and small enough that I barely even notice if it’s in my bag. It easily lasts a week between charges with my usage. I was also able to build [workflows](https://workflow.is) which make the process of creating posts in the format I use for [ftrsn.net](https://ftrsn.net) incredibly easy. Once written, posts take two taps to publish.

Now it comes to what I *don’t* like about Wordpress. It essentially boils down to this: it’s gross. The Wordpress console might be powerful, but I never look forward to using it. It feels like a Frankenstein app, hacked together out of miscellaneous spare parts. When you activate a plugin, it’s free to do just about anything it likes. I’ve found at least three different places in the console UI where plugins might install their settings pane. It’s clunky, and slow. The version of the Wordpress console used on Wordpress.com is quite clean and pleasantly designed, but clearly [Automattic](https://automattic.com) are keeping that for themselves. But even then, I know it’s php under the covers.

But what of Ghost? I did say I was sticking with it and planning to use it again in the future.

Ghost tends to be more expensive to host (especially if you use Ghost’s own plans, which are now aimed a professional publishers[^4]). As for ease of setup, the new [Ghost CLI](https://docs.ghost.org/docs/ghost-cli) has actually made that pretty easy. With it in place, I think I’d actually be more comfortable self hosting Ghost than I would Wordpress.

At the time of writing there is no such thing as a Ghost plugin. There is a thing called an [“app”](https://apps.ghost.org), but thus far only first party apps are available. Happily with Ghost I don’t really need much in the way of plugins at the moment. What I do need can be accomplished via code injection, [IFTTT](https://ifttt.com), or with the first party apps which are available.

Ghost also has no UI for editing themes. Themes are uploaded as .zip files, and applied to your site as is. This means that to configure Cedar to work the way I want I had to edit 1 Javascript file, and several [handlebars](https://handlebarsjs.com) files directly. Nothing too onerous, but still more hassle than the Wordpress equivalent.

The workflow for uploading to Ghost isn’t as nice. I have to copy and paste into the web UI, rather than just clicking two buttons in Ulysses. But that’s fine for a blog I update every *cough* few weeks *cough* (as opposed to one I update a few times a week).

Despite all of the above, I really like Ghost. Workflow issues aside, it’s a pleasure to use. It’s fast and well designed. If I need to edit the theme of my site I’m not horrified by what I find there.

Going forward a lot of the long posts I had planned for [ftrsn.net](https://ftrsn.net) are going to be cross posted here, or posted here and linked to from there. They’re about my journey in trying to skill up on Machine Learning, and that feels like more of a good fit for this site.

[^1]:	It actually shook out to just under £20 once VAT and credit card fees were applied.

[^2]:	Although there are options which are neither, if that’s what you’re looking for.

[^3]:	Or even my iPhone, if I need to make a quick edit on the go.

[^4]:	Thankfully they’re keeping me on a “legacy” plan, which is only costing me a few pounds a month.