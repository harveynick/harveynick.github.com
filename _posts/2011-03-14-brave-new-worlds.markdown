---
layout: post
title: Brave New Worlds
date: '2011-03-14 22:48:18'
tags:
- bibliophile
---

If you were writing a taxonomy of stories you might choose books as a good place to start. Flicking your way through the world's libraries, time and the Dewey Decimal System would eventually bring you to the fantasy genre. There is a lot of fantasy writing out there, and you might choose to subdivide it further. A one potential way of cutting it neatly in twain is like so: 

  1. Stories set in our world;
  2. Stories not set in our world.
  
Simple. Harry Potter, for instance, is set in our world. That's a big part of the appeal. Likewise so are [Neverwhere], [Kracken] (if you liked Neverwhere, you'll want to read this), and most of Stephen King's work. Lord of the Rings is not set in our world. Simple. There are other options, of course. What about the  Chronicles of Narnia, for example (which is set in a world beyond our own)? Or Magic Bites[^1] (which is set in an alternate version of our world)? Clearly we're looking at some shades of grey here as well, but I'm sticking the with the original idea while it still serves my purpose.  

[Neverwhere]: http://www.amazon.co.uk/Neverwhere-Authors-Preferred-Neil-Gaiman/dp/0755322800/ref=sr_1_1?ie=UTF8&qid=1300142138&sr=8-1
[Kracken]: http://www.amazon.co.uk/Kraken-China-Mieville/dp/0330492322/ref=sr_1_1?s=books&ie=UTF8&qid=1300142157&sr=1-1

<!-- More -->

What is my purpose here, though? Why the ramblings on this most nerdy or genres? Well, I'm thinking about procedurally generated landscapes again, you see. Clearly, if you're generating your landscape procedurally, it's going to be entirely of this world. Existing fantasy landscapes are a good place to look for ideas, then, particularly because they were designed specifically for the purpose of telling stories in.  

The quintessential fantasy landscape is, of course, Tolkien's Middle Earth, which looks a lot like this:  

[![](http://war3.incgamers.com/uploads/MiddleEarthRisk792Kofficial1291674287.w3x-1.jpg) ](http://en.wikipedia.org/wiki/Middle-earth)

That should look vaguely familiar to anyone who's read the films or seen the books (or words to that effect). There's a definite feeling of size there. Clearly we're looking at a chunk of a continent, split into something not unlike countries. It always bothers me on maps like this, though: what about the rest of it?  
There are a couple of well known knock offs of Tolkien's work out there, so why don't we consider a few of those as well? One which used to be close to my heart in my adolescent years is Games Workshop's Warhammer:  

[![](http://www.scenicreflections.com/files/Warhammer_Map_of_the_World_Wallpaper_0495o.jpg)](http://en.wikipedia.org/wiki/Warhammer_Fantasy_(setting))

Now, it should be quite obvious that the good chaps at GW are knocking off more than just Tolkien here. The Big G / the anthropic principle (depending on your world view) could probably claim some royalties here, because the shape of some of those continents looks very familiar. Grand Cathay, indeed. Now we appear to be looking at close to an entire planet, though, unwrapped using something not unlike the good old Mercator projection (or possibly something more politically correct). I assume so, anyway. It's entirely possible that the Warhammer world is flat.

Another world with more than a bit of Tolkien about it it the World of Warcraft:
  
[![](http://world-of-warcraft-gold.com/images/worldofwarcraftmap.jpg)](http://en.wikipedia.org/wiki/World_of_Warcraft)

Blizzard have taken no chances, though. This is a world you can actually go wandering about on, virtually speaking. They've made sure there aren't any inviting edges for you to go wandering off. If this isn't the entire of the world, it is at least self contained. That doesn't stop Blizzard causing new continents to pop to surface whenever they need to make new content, of course.  

Okay, I'm only going to show one more, then I'll get to the actual point. This is a big one, though, so take a deep breath:  

[![](http://shaghaghi.net/wp-content/uploads/2010/11/WesterosMap1.jpg)](http://shaghaghi.net/wp-content/uploads/2010/11/WesterosMap1.jpg)

This is also one you might be less familiar with. If you haven't already, I heartily suggest you take a look at George R R Martin's "A Song of Fire and Ice" series, which starts with "[A Game of Thrones]," which is not coincidentally the name of the TV adaption of the books which starts on HBO quite soon. This is probably the best of the four maps I've posted here, thanks to a fairly stupid amount of detail (click on it, I dare you). This detail is evident in the books themselves (which I have to confess are not for the faint of heart) as well. This giant map actually represents only a smallish portion of the world these books are set in. It makes a good illustration though. We have mountain ranges, plains, rivers, cities, castles and so on.  

[A Game of Thrones]: http://www.amazon.co.uk/Game-Thrones-Song-Fire-Book/dp/000647988X/ref=sr_1_1?ie=UTF8&qid=1300142459&sr=8-1

If I'm going to procedurally generate a landscapes to tell stories in, they need to have at least a percentage of this amount of detail. Take "The Neck," the narrow portion of land around halfway up, for example. The fact that the land perceptively narrows here feeds heavily into the plot at several points in the books. This is a choke point which cuts the continent in half. Likewise, "The Eyrie" (*shudder*) is a fort sitting at the peak of a mountain range. Towns are in places that towns would be placed: bridging point on rivers, sheltered harbors, and so on.  

The point is this: my procedurally generated landscapes will need variety, but the right kind of variety. They will need "features." That's the first major problem I'm going to need to work on once the basic engine is in place, but first I need to make a decision: should this be done top down, or bottom up? Or some combination of the two?  
First, though, I need some terrain simplification and some unit tests. The unit tests I'm actually quite looking forward to doing (oddly), since I'm going to try doing them in Groovy.  

PS I wanted to include the world from Brandon Sanderson's utterly spectacular "Mistborn" series here as well, but I couldn't find a good map online. These books are truly awesome, though. As well as been part of a series, each actually stands alone and completes it's own story, unlike the fast majority series in the fantasy genre. Seriously. [Read them](http://www.amazon.co.uk/Final-Empire-Mistborn-Book-One/dp/0575089911/ref=sr_1_1?s=books&ie=UTF8&qid=1300142644&sr=1-1).  

[^1]: Confession: I enjoyed this book, even if there is a gramatical error in the first sentence. The very first sentence.
