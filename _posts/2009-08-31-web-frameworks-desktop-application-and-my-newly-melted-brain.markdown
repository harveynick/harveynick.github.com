---
layout: post
title: Web Frameworks, Desktop Application and My Newly Melted Brain
date: '2009-08-31 22:14:07'
tags:
- hacker
---

Let's get the preliminaries out of the way: Hello, long time no see, how have you been? Etc...  

So, whilst writing up my PhD (experiments finally finished!) and working three days a week (going fully full time at the end of September!) I have a fair bit on my plate at the moment. So obviously I've also started cooking up a side project...  

<!-- More -->

I don't want to talk too much about what it actually is (mostly because I don't know how "open" I want it to be yet), but it's definitely going to require a web service. It might also require a fully fledged website (lets call this the spotify model), or it might just use a desktop application which connects to the service when it needs to (lets call this the iTunes model). Then again it might have both, with the desktop application providing some extra functionality which is hard to do over the web or in the browser. I think there's also scope for a mobile application, so lets throw iPhone and (what the hell) Android into the pot as well.  

I had a bit of a poke around with some web development frameworks first, since this is probably the bit I know least about.  

One of the first solutions I came across was [Django], which is based on the [python] language. It looks good, through I have some issues with its handling of "one to many" relationships. Python is a language I have limited experience with, but it gets a lot of love, and people are putting a lot of work into into making it better. It also has good integration with native libraries. So that's nice. It's also named after Monty Python, which only raises my opinion of it.  

[Django]: http://www.djangoproject.com/
[python]: http://www.python.org/

I'll essentially skip over [TurboGears] and [Web2Py], two other python based frameworks I did some reading about. Django seems like the best choice out the python based frameworks I've looked at.

[TurboGears]: http://turbogears.org/
[Web2Py]: http://www.web2py.com/

Soon afterwards I discovered [Grails] which is based on the very cool [groovy] dynamic language. Groovy, as well as being fun to say, is implemented directly on top of Java, by far the language I'm most comfortable with. The are a lot of existing Java libraries, and groovy has _perfect_ integration with them. Groovy and grails have some serious weight behind them, also.  

[Grails]: http://grails.org/
[groovy]: http://groovy.codehaus.org/

One framework I hadn't really considered was [Ruby on Rails], which is in many ways the daddy here. This is mostly because I dismissed [Ruby] as a language out of hand. It looks mental. For reasons I'll come to in a minute, I've re-evaluated this desision, and will be having a good long look at it. On the one hand it's been around a good long while, so has had the oportunity to become more refined. On the other hand, it was the first of its kind, which means it might also be stuck with some bad early design desicions. It's the original, this might not make it the best. I don't know yet.  

[Ruby on Rails]: http://rubyonrails.org/
[Ruby]: http://www.ruby-lang.org/

In order to build this... thing, I'll need data representation, I'll need algorithms for processing this data, and I'll need ways of displaying it. I'd rather not have to deal with multiple implementations in different languages, particularly with the algorithms.  
Problem.  

If I want to make desktop applications, python is a possibility. It has good bindings to GTK and QT for linux, and Cocoa for OSX (there's probably also something which will work on windows, and at some point I'll probably have to care about this). Java will work anywhere, but it's quite difficult to make a desktop application with Java which won't look like crap. My priority in this area is going to be OSX, and Java does not measure up here. I had not considered Ruby, until I came across MacRuby, which is a _very_ interesting idea. It's not a bridge or a set of bindings, you see, it sits right on top of the objective-c runtime. All of a sudden, Ruby and Rails are a contender.  

In the mobile space, things get shitty. iPhone requires objective-c, Android requires Java. 

Bugger.  

So here's where I am: I think groovy is a better language than python (and probably ruby), and I think grails is a better framework than django (I'll get back to you regarding rails)... but I'm not sure I want Java hanging around my neck when it comes to building a desktop application. I might also need some serious grunt in the algorithm stakes, and I'm not sure I want to do that in a scripting language. Yes, I need to be able to implement it quickly, but I also need it to run quickly. I'm not sure I want to do that in either C or C++. Java would be good for this (and yes, it's plenty fast). Objective-c is an option I haven't discounted.  

The search continues... any thoughts?
