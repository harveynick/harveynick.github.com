---
layout: post
title: Revisiting the Language Issue
date: '2011-09-14 08:00:14'
tags:
- hacker
category: "Procedural Landscape Generation"
---

Some time ago, I wrote a [series][] [of][] [posts][] [about][] [language][] choice for my Clockwork Aphid project. In the end I decided to start the project in Java, this being the language I'm most comfortable with. Once the project reaches a stable state, with some minimum amount of functionality, the plan is to port it to C++ for comparison purposes, this being the language which is likely to provide the best performance. 

[series]: /2010/10/09/youre-speaking-my-language-baby-part-1-introduction
[of]: /2010/10/10/youre-speaking-my-language-baby-part-2-java
[posts]: /2010/10/11/youre-speaking-my-language-baby-part-3-c
[about]: /2010/10/12/youre-speaking-my-language-baby-part-4-objective-c
[language]: /2010/10/13/youre-speaking-my-language-baby-part-5-conclusion

I still plan on doing this, but I've also decided to add a couple of extra candidate languages to the melting pot and get an even broader comparison. The first of these languages is Go, a relatively new language developed at Google. This is not coincidence. I've been doing some reading about it lately and finding a lot of things I really like. It has the potential to provide the benefits of both Java _and_ C++, whilst avoiding many of the pitfalls. This is definitely a good thing. It will also give me chance to dogfood (there's [that word] again!) some more Google technology.  

<!-- More -->

One of Go's features which I really like is implicit interfaces. Allow me to explain. In most regular statically typed object orientated languages, such as Java (which I'll use for this example), you can abstract functionality using something like an interface. For example, let's say I have a class which looks like this: 

[that word]: /2011/08/26/dogfood-nom-nom-nom
    
```java
class Counter {
  int value;
  int get() {
    return value;
  }
}
```

Here we have defined an class which declares a single method which returns an integer value. I might then make use of this an instance of this class elsewhere: 
    
```java
class Printer {
  void update(Counter counter) {
    System.out.println(counter.get());
  }
}
```

All is good with the world, unless I decide I want to change the behaviour of the code. Perhaps I want the value to increment after each call, for example. I could extend the Counter class and change its behaviour that way: 
    
```java
class IncrementingCounter extends Counter {
  int get() {
    return value++;
  }
}
```

I can now pass an instance of this new class into the update method of the Handler. Done. Right? Well... no. This is a bit of a clumsy way to go about this. It doesn't scale and it's not always possible. A better way to handle this is to use an interface: 
    
```java
interface CounterInterface {
  int get();
}
```

This specifies the interface of the methods, but not their implementation. We can then change the Printer class to use this interface, rather than the concrete class: 
    
```java
class Printer {
  void update(CounterInterface counter) {
    System.out.println(counter.get());
  }
}
```

Now any class which implements this interface can be passed to the Printer. So, going to back to our original example: 

```java
class Counter implements CounterInterface {
  int value;
  int get() {
    return value;
  }
}
```

We can now make any number of alternative implementations (incrementing, decrementing, random, fibronatchi…) and as long as they implement the interface they can be passed to the printer. This is fine if you're in control of the implementation, and even more fine if you're in control of the interface as well. There are times, however, when you're in change of neither. Things can get a little messy and you may have to find a way of pushing a round peg through a square hole.  

In dynamically typed languages, such as Python and Ruby, things work a little differently. These languages are often referred to as being "duck" typed, as they make the assumption that if something "looks like a duck and quacks like a duck, treat it as though it's a duck." In this case we wouldn't bother with any of the interfaces and our Printer class would look more like this: 
    
```python
class Printer:
  def update(counter):
    print counter.get()
```

So long as the counter object has a method called get() we don't have a problem. Everything will be fine. This is much simpler, and is one of the things which makes Python very quick to program in, but it does have problems. The main problem (for me, at least) is specification. Without examining the source code, I can't see what sort of object I have to pass into the update method. If the method has been manually commented then there's no problem, but this is an incredible tedious thing to have to do. In the Java code I can see the type right there in the auto-generated documentation, and even if the writer has written no comments at all (what a bastard!) I can still get a good idea of what I need to pass into the method.  

Go takes a different approach. It's statically typed, and it has interfaces, but a class doesn't need to state that it implements an interface. This is implicit and automatic. If a class has the methods defined in an interface, then it is automatically considered to implement it. You get the flexibility of Python with the specification and predicability of Java. This is just one of the things in Go which I think is a really good idea.  

On the other hand, I think functional programming is a really stupid idea. I find the languages to be completely horrendous. I feel they must be created by the sort of people who think Linux is user friendly. I consider them curiosities whose only merit is academic. It appears to me that their major use case is to make programming appear more obscure than it actually is and to abstract way the programmer's knowledge of what the computer is actually doing.  

You may be surprised to learn, then, that the third language I'm going to be trying to port Clockwork Aphid into is Scala, a functional programming language. The reason for this is simple: while I personally believe that functional programming (FP) is rubbish, many people disagree. Not a majority, but certainly a very vocal minority. Within Google this minority is very vocal in indeed. The word "fundamentalists" might be appropriate to describe them. When someone believes something that hard it makes me very curious. This is turn tends to lead me towards testing my own beliefs. Sometimes I discover something new and exciting which I was missing out on previously[^1], and sometimes my initial suspicions are confirmed[^2]. We'll see which way it goes with Scala.  

[^1]: Such as the Harry Potter books, which I had stubbornly refused to read until just before the first film was released.  
[^2]: Such as when I noticed that the Twilight books had taken up the first four places on the Waterstone's chart and decided I aught to find out what all the fuss was about.
