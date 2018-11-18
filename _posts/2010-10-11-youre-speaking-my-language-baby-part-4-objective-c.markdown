---
layout: post
title: 'Youre Speaking My Language Baby Part 4: Objective C'
date: '2010-10-11 22:00:00'
tags:
- hacker
---


The last language I'm considering is **Objective-C**. I know this language the least of three (which is to say: I don't know it at all). To make matters worse, while Java and C++ share a similar syntax, Objective-C is completely different in places. That being said, it's semantically very similar to Java (more so than C++) and people who know it well speak very highly of it. i.e. it does not appear to be anywhere near as broken as C++. The language itself has some dynamic capability built in, but also has all of the additional dynamic options available to C++ (more on that later) and an excellent Ruby implementation which sits directly on top of the Objective-C runtime ([MacRuby]).  

<!-- More -->

[MacRuby]: http://www.macruby.org/

In general, Objective-C should be faster than Java, but not as fast as C++. It doesn't use a virtual machine, but it does have a minimal run time which is used to implement the more dynamic message passing paradigm it uses in place of standard message calls between objects. It also has optional garbage collection, allowing you to make a choice between stability and performance when you need to (i.e. you can get the code working and worry about the memory allocation later). It's also able to leverage all of the power of both the [LLVM] back end and the newer [Clang] front end, which C++ currently can't.  

[LLVM]: http://llvm.org/
[Clang]: http://clang.llvm.org/

While there aren't a lot of directly relevant tools available for Objective-C itself, it is able to directly use any code or library written in either C or C++. No problems there, then.  

It's the last metric which is the kick in the teeth fot Objective-C, though. In short: no one really uses it unless they're programming for an Apple platform. As a result, unless you're programming specifically for either OSX or iOS you'll loose out on a lot of frameworks. Objective-C is a first class language in the Gnu Compiler Collection (GCC), so it can be deployed easily enough under Linux (minus a lot of the good frameworks). This is not the case under windows, however, where there doesn't seem to be any good deployment options. I have no problem ignoring Windows, but directly precluding it would appear to be somewhat foolhardy when building a piece of technology related to computer games. It wouldn't be too much of a problem if I was only doing this as an academic exercise, but I actually have delusions of people using it.  
