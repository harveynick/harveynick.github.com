---
author: harveynick
date: '2010-11-03 22:17:08'
layout: post
slug: a-short-note-regarding-the-deafening-silence
status: publish
title: A Short Note Regarding the Deafening Silence
wordpress_id: '406'
categories:
- Blogger
- Hacker
---

For a while there it really looked as though I was on top of this whole blogging lark, didn't it?  

The problem is that writing this blog (and to an even greater extent, working on the Clockwork Aphid project) doesn't feel like procrastinating. It feels like doing something. Not working exactly, but definitely making an active contribution.  

As a result, if there's something else I'm supposed to be doing with my time, I have a really hard time working on either without the guilt setting in (it's happening right now). This doesn't stop me from dicking around on the web, complaining about the latest change to Facebook and working my way through my mountain of articles which get dumped into my RSS reader on a daily basis, of course. They do feel like procrastinating, you see, so I waste plenty of time doing those.  

<!-- more -->

This is one of those times when there's something more important I need to work on.  

Hopefully I'll be able to talk more about it later. That doesn't mean I'm not spending time thinking up new blog posts (I have at least three fairly big ones sitting in my head) or going over possible implementation strategies for Clockwork Aphid (I probably need to find a catchier name for that). At the moment I'm giving some thought to the management of the landscape data. As in: 

  * How much do I show to the user?
  * How much do I keep in memory?
  * How much do I keep on the disk?
  * How much do I keep just on the server?
  * Also: why don't I use more bulleted lists?
  
To help with this I'm doing a bit of research and reading a journal paper called "_Terrain Simplification Simplified: A General Framework for View-Dependent Out-of-Core Visualization_" by Peter Lindstrom and Valerio Pascucci. The previously mentioned Shamus Young used in one of his previous projects and talked about it [here](http://www.shamusyoung.com/twentysidedtale/?p=142). The links he gives are dead now, but if you're interested you can find a copy of the paper by googling the title.  

As for Shamus' current [project](http://www.shamusyoung.com/twentysidedtale/?p=9686), he's doing something with a landscape subdivided in hexagons. This makes me think it might be some sort of turned based game, as hexagons have the nice side benefit of being equidistant from their neighbors (measuring the distance from centre to centre). Interesting... This makes me wonder if there's a good method of doing fractal subdivision using a hexagonal (rather than square) topography...
