---
layout: post
title: Language Post Mortem and Some Other Notes
date: '2010-10-16 09:53:40'
tags:
- hacker
category: "Procedural Landscape Generation"
---

A couple nuggets of knowledge came out of my "You're Speaking My Language, Baby" series of posts, so I though I'd just take a quick moment to talk about them.  

The first two are perhaps the most obvious by far. Firstly: if you actually write blog posts, people are more likely to read your blog. Funny that, huh? While my post on installing [Celtx on the Acer Aspire one] is still my most popular by some margin (probably because it actually provides some utility), I actually had my highest numbers of hits per day during the last week. Secondly: I get less hits over the weekend. Lax working habits for the win!  

[Celtx on the Acer Aspire one]: /2008/08/24/mdl-celtx-on-the-acer-aspire-one

<!-- More -->

What's also interesting is the relative popularity of the individual parts of the series. Most popular first, it goes like this: 

  1. Introduction
  2. C++
  3. Conclusion
  4. Java
  5. Objective-C
  

Now, my number of hits still isn't exactly stellar, so this is a fairly small sample size, but it's still quite interesting. People seem to be far more interested in reading about C++ than any of the other languages. In general, readers tend to want to know what it is I'm actually talking about, and what conclusion I come to, but when it comes to specifics, C++ gets the most interest. Is this a recommendation of the language, or the oposite, though? People could be reading what I say about it because they think it's the sensible option... or because the folly of the language makes them seethe with rage. Hard to say. Perhaps I'll look for some metrics of programming language popularity online.  


In one of those curious events the internet throws up, the writer of a blog I read on a regular basis also just started to work on a project of a potentially similar nature, and started off with some musings on which programming language to use. I'm talking about Shamus Young in his [Twenty Sided] blog (I should really add it to my blog roll). Interestingly, and slightly comically, he came came to an equal and oposite conclusion to my own. He didn't consider Objective-C (not out loud, anyway), but decided that Java was the language to use if he wanted to produce something with commercial viability, but C++ was the language to use if he wanted to do some prototyping.  

[Twenty Sided]: http://www.shamusyoung.com/twentysidedtale/?p=9644

I'm still scratching my head at this in some ways. I don't care how much experience you have in C++, you're still likely to program faster in almost any language other than C. But in other ways it makes perfect sense. He has about a decade's worth of experience with C++ (likewise I have about ten years worth of Java under my belt), but only limited exposure to Java. He's looking at building a complete game, so he's being influenced by games like [Minecraft] (which I will be talking about more later) which were successfully developed by an individual (in Java, as I understand it). If you're making something a bit niche and you don't have massive amounts of resources, then having a game which can be effortlessly ported to every major operating system is a good thing. You want to expand you potential audience as much as possible. Also, if your target demographic slants towards the nerd side of the spectrum then you don't want count out Linux, nor OSX (which gets more nerd love than you might expect). Having your game be able to run out of a browser doesn't hurt, either.  

[Minecraft]: http://www.minecraft.net/

I'm not (at this point) looking at building a complete game, but a piece of technology which could potentially be used by multiple games, though. Something of the order of a physics engine. Middleware is the term I seem to hear used. Thus Java (which I have more experience with) is my prototyping language, but C++ makes sense as an eventual target.  

I've been holding back on what I'm actually doing, but I essentially outed myself when I said it was similar to what Shamus is. So: I'm doing something connected to procedural content generation. I'll explain more about what that means as I go along.  

In other news I have two weeks off work. Seems I haven't used the vast majority of my holidays this year and taking the entire month of December off is not considered to be ideal. Thus: I have two weeks to do with as I please. I may visit my parents or even some of my friends down south. I'll also spend quite a bit of time sitting in coffee shops with a book and a note pad. Coffee shops are good places to think, I find. Just the right amount of bussle. I'm also going to crack on with Clockwork Aphid. I'm tinkering with some implementation details at the moment, but I plan on writing about what I have so far as well. I'm also hoping to make the Heston Blumenthal chilli con carne I mentioned in a [previous post], but there are complications. Firstly, he's quite specific about the types of chilli powder you should use and some only seem to be available from the good ol' USA. They're on order, so hopefully they'll arrive fairly soon. Secondly, there's clearly a mistake in the recipe, unless Heston want me to boil a pan of water and prepare a bowl of ice water for purely ornamental purposes. This isn't completely outside the bounds of reason.  

More updates soon. Look to the skies!

[previous post]: /2010/08/24/its-hestontastic
