---
layout: post
title: 'The Day Job Part 2: Let''s get SAUC-E!'
date: '2011-01-22 17:08:34'
tags:
- hacker
---

If you know when I started my PhD you'll be aware that it took quite some time for me to finish it. There are various reasons for this. One is that I spent quite a bit of time working and getting industrial experience during it. The other is that it took me something in the region of 18 months to figure out what it was I was actually going to do. This happens quite a bit at the Ocean Systems Laboratory, you don't actually start working on a particular project or problem, you just sort of find something which seems to need doing. It also didn't help that it talk me 9 months to get any feedback on the first draft of my thesis. One of the major things which took up my time, though, was the Student Autonomous Underwater Challenge - Europe, or SAUC-E for short.  

This post is going to focus on my own part in the proceedings, but you should assume that everyone else on the teams worked at least as hard as I did, and their contribution was at least as important as my own. This is _my_ blog, though, so I'll mainly be talking about me.  

<!-- More -->

Basically, teams of students build an underwater robot which then has to complete an obstacle course. Let me stress: it is not in any way like Robot Wars, so you can abandon that notion right now. The crucial word here is autonomous, as in you have no contact with the vehicle after you push go; it all has to run on autopilot. The first competition was just ramping up when I joined the OSL and I offered to go along to the site and help out. The fact that it was held at Pinewood Studios (which is a movie studio, not a furniture store) was no small bonus (I've wandered about on the sets for Casino Royale and Stardust), but the competition itself was also very cool indeed. I leapt at the chance to be part of the team for the second year of the competition, and then stared in disbelief as a technical issue nuked our chances right before the final. Up until that point we'd been leading the field by quite a margin, so finishing second to last was no fun at all.  

The next year myself and one of my colleagues decided this wasn't going to happen again, so we damn near killed ourselves working sixteen hour days for a couple of months, and then we took the robot to France for SAUC-E 2008. Each year there are a number of supplementary tasks which must be completed. One is to write a paper (or "report" if you're not down with the academic lingo) about your entry, another is to produce a video diary. Our video diary for the 2008 competition does a pretty good job of showing our frustration at the previous year's result and the amount of preparation we put into it this time round:  

{% include youtube.html video="Mkv2YXqYfhQ" %} 

It was a hell of a lot of work, but we got there and we damn well kicked everyones' asses. In the final we cleared the entire course on our first try. Everyone else used their entire twenty minutes of time. We used about seven. It was a good feeling. This isn't a hugely fascinating video to watch and, but here's the official video of out final run:  

{% include youtube.html video="yDrofT4BVm8" %}

What you don't say in that video is me standing on a table with a microphone in my hand narrating what I think the robot is doing, then the entire team practically leaping into the air when it completed the course. Still, here's a picture of us (minus one team member who had to leave a day early) from an article in an industry journal:  

[![](http://www.hydro-international.com/wosimages/661_368.jpg) ](http://www.hydro-international.com/news/id2669-HeriotWatt_University_Triumph.html) 

The next year we reworked a lot of the electronics and moved to a much more hydrodynamic external design. This was a good thing, because previously Nessie had been slow, and now the competition area was a lot bigger. The 2009 video diary sums it up:  

{% include youtube.html video="CqgOsPazxvU" %}

Most of the tasks were adaptations of those from previous years, but a fairly intense new one was also introduce: dock inside an elongated box placed on the floor of the pool. None of the other teams even attempted this last task, but I'd arrived a little late to the on site practice time thanks to other commitments. Everyone had their jobs and things were running pretty well. My responsibility was the mission controller (the captain, if you want to use a ship's crew as a metaphor) and we weren't quite ready to start doing any serious tests with this yet. So I started working on a strategy to do the docking. There was plenty of grunt work for me to help out with; I did some code review and put together some mission plans, but at this point I was essentially surplus to requirements. So I messed about with the docking thing.  

![](http://harveynick.files.wordpress.com/2011/01/img_0129.jpg) 

First of all, I built a detector which could find the box from above. I'm not really a computer vision guy, but after a lot of experimentation and playing I managed to put something quite stable together. There was no space in the practice pool to actually attempt the docking itself, though. I put a behaviour together which I was pretty sure would get the vehicle into the box, but I had no reliable way of testing it. I put it to one side and got on with the serious business of the competition itself. This was held at a different location, so needless to say every algorithm needed to be re-tuned to the new environment.  

One of the other teams did very well in the qualifying stages and went into the final in second place by a very narrow margin. We new what we could do, and we know what they could do. They had a much better sonar, but no cameras, so some tasks were just plain out of their reach. Even so, it was going to be close. The day of the final we got a bit of extra practice time in the morning. At this point the docking had received about ten minutes worth of practice time, and it's performance had not been what you would call "successful," exactly. I was fairly sure the last night's late night coding session had found all the bugs, though. "Fine," said the team. Give it a shot, but we don't want to waste too much of the practice time on it.  

It worked first time.  

"Did anyone see that?" There was a judge at other side of the pool, but no one was looking at us. We wouldn't get any points, but still, we wanted the judges to SEE it. Someone from one of the other teams saw some of it though, it seems, because they took this video:  

{% include youtube.html video="Gp0fXXHX-So" %}

Out supervisor came running over. "Was that autonomous?!" He demanded. Apparently one of the other judges was standing at the monitors and there was a camera inside the box. There was a little bit of a buzz.  

We tried it again. It worked again. This time someone had actually put a tape in the VCR, which is nice, but I don't have that video.  

The organisers were smiling, but not in a 100% friendly way. No one was actually supposed to pull off the docking this time around. But we had. There was no time to add this behaviour into the plan for our main run in the final, but this year there was a new rule: you could demonstrate the tasks individually to pick up extra points. The final, as it turned out, was not quite as close as we were worried it might be, and Team Nessie picked up another first prize.  

[![](http://www.hydro-international.com/wosimages/1155_299.jpg)](http://www.hydro-international.com/news/id3320-SAUCE_Victory_for_Nessie_IV.html)
 
As well as the industry journal from which the above picture has been taken, the BBC paid some attention to the competition this time around, as well (which you can find [here](http://news.bbc.co.uk/1/hi/sci/tech/8143541.stm)). Yep, that's me at the end of the video. They interviewed me for the article they wrote on the competition and used a lot of my quotes. I learned an important lesson from this: assume anything you say to a journalist will be taken literally, and don't assume that they'll check their facts, even if you specifically tell them to because you're not certain of your numbers. For example, the figure of £10,000 mentioned in the article is actually closer to £100,000.
