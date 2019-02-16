---
layout: post
title: 'You''re Speaking my Language, Baby. Part 5: Conclusion'
date: '2010-10-13 11:00:04'
tags:
- hacker
category: "Procedural Landscape Generation"
---

So... what's the conclusion? It mostly comes back to the fact that I'm doing this mainly for fun (though you may have trouble believing it). That being the case I'm going to start working in Java. In fact I already have started working in Java, and I've already written the first bits of code. I'll talk about and make them available soon.  

<!-- More -->


I just can't ignore the sheer applicability of C++, though, much as I may dislike it as a language. Most game developers are going to have the majority of their legacy code written in C++ and that creates a lot of momentum. Games are among the more demanding things most people do with their computers, so they generally try to squeeze every last drop of performance out of the system they're running on. C++ does have the potential to provide a performance advantage over Java (even if you might end up loosing that to your AI system when you starting having to use Lua to script behaviours). Another one of the reasons for this project was to create a bit of work which might act sort of like a portfolio piece. So, once the project has reached an early, but functional, stage of development I'm going to re-implement it in C++ and then see how I feel about the two different implementations before continuing. It's not impossible that I'll end up keeping both, but more than likely I'll kill one and just stick with the other.  


By a process of elimination you might have realised that I'm now counting Objective-C out. This is true, but I have another side project I may end up using it on. One which lends itself quite well to being either an iPhone/iPad app or a website. Or all three. Objective-C is clearly quite applicable to the first two, and surprisingly applicable to the last, if you go the Objective-C -> MacRuby -> Ruby on Rails route.  

That was the plan, at least, until I went ahead and did something silly. I have more than a passing interest in programming language design and so found myself reading about other programming languages. Stupidly, I found a couple which have enough merit that I really can't count them out.  

The first of these is [D], which is designed to fix a lot of the problems with C++ whilst maintaining its advantages. It seems to succeed at this quite well, so far as I can tell. It also seems to have direct access to a lot of things built directly for C/C++.

[D]: http://www.digitalmars.com/d/

Then we have [Scala] and [Fantom], which use the Java virtual machine as their runtime. Both seem capable of achieving the same level of performance as Java itself, but take away some of the legacy cruft which Java has been unable to shake, whilst adding extra useful features. Scala I'm only just starting to learn about, but people seem to like it a lot. Fantom, I think, might be perilously close to being the perfect programming language by many metrics, though. Don't take my word for it, have a read about it. I dare you not to be impressed (assuming, of course, that you are the sort of person who gets impressed with these sort of things). It adds some very cool extensions and has direct support for some very useful things, such as allowing both dynamic and static typing under the developer's control.  

[Scala]: http://www.scala-lang.org/
[Fantom]: http://fantom.org/

Both Scala and Fantom can transparently use libraries written in Java, though Fantom can also deploy to both .net and javascript (for web development).  

All three of the these languages are interesting enough for me for to not count them out entirely, so I might also try a port to one or more of them.  

As always, comments are welcome, so please feel free to try and convince me of the error of my ways. Keep it civil, though, I know how excited programming language discussions seem to make some people.
