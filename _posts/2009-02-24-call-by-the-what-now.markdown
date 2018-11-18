---
layout: post
title: Call by the what now?
date: '2009-02-24 23:40:04'
tags:
- hacker
---

Some not work related computery bits and pieces have been percolating around my head for some time now. I think we should talk about them for a while. That is: I'll talk. You listen.  

I'm probably going to write a couple of more techy blogs, all loosely interrelated. I am going somewhere with them, but I'm not entirely certain as to how much of this journey I will share with you.  

<!-- More -->

First of all, I'm going to talk about the fairly simple computer related concept of "Call by reference" versus "Call by value". This is fairly basic computer science (though I wish they'd taught it properly earlier on in my course). It's possible (probable, even) that this example (or variations of it) has been used a thousand times before. I'm not going to go look for one (or the absence of one), I'm just going to write down my own particular take on it. I assure you that any plagiarism I'm about to commit is in no way deliberate. So, without further ado...  

Let's say you want to send a specific piece of information to someone via email. Let's say it's part of today's featured article on Wikipedia (William I of Orange, at the time of writing). In today's connected digital world, you have too main options. First of all, you could send them the information itself, like so: 

> William was born in the castle of [Dillenburg](http://en.wikipedia.org/wiki/Dillenburg) in [Nassau](http://en.wikipedia.org/wiki/Nassau_(duchy)), present-day [Germany](http://en.wikipedia.org/wiki/Germany). He was the eldest son of [William, Count of Nassau](http://en.wikipedia.org/wiki/William_I,_Count_of_Nassau-Dillenburg) and [Juliana of Stolberg-Werningerode](http://en.wikipedia.org/wiki/Juliana_of_Stolberg), and was raised a [Lutheran](http://en.wikipedia.org/wiki/Lutheran_Church). He had four younger brothers and seven younger sisters: [John](http://en.wikipedia.org/wiki/Johan_of_Nassau), Hermanna, [Louis](http://en.wikipedia.org/wiki/Louis_of_Nassau), [Mary](http://en.wikipedia.org/w/index.php?title=Mary_of_Nassau&action=edit&redlink=1), Anna, Elisabeth, Katharine, Juliane, Magdalene, [Adolf](http://en.wikipedia.org/wiki/Adolf_of_Nassau) and [Henry](http://en.wikipedia.org/wiki/Henry_of_Nassau-Dillenburg).

There are several things your recipient can do with this. They can read it. They can edit it, but this will only edit their local copy. The original remains unchanged. If they want to request that a change be made, they can, however, edit it and send it back to you. This is "calling by value."  

Your second option is to send them a link to the information: 

> [http://en.wikipedia.org/wiki/William_I_of_Orange#Early_life](http://en.wikipedia.org/wiki/William_I_of_Orange#Early_life)

This, again, allows them to read it. They have to follow the link to the information it points to first, though. This time, if they make an edit (this being wikipedia) they actually are changing the original copy. They can also see what other information is around it, and if they feel so inclined they can change that is well. You might consider this to be an undesirable consequence. This method has the aditional advantage, however, that you did not have to take the time and effort to make a copy, and the amount of information you had to actually send is significantly smaller. This is "calling by reference."  

If you deal with this sort of thing on a day to day basis, you may well be aware that when you do this sort of thing in a computer program you have another option. You can send a constant reference, which would be analagious to sending a link to a website the recipient has no write access to. For example: 

> [http://www.britannica.com/EBchecked/topic/644041/William-I](http://www.britannica.com/EBchecked/topic/644041/William-I)
