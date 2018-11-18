---
layout: post
title: Some Notes on the “Andrew Ng” Coursera Machine Learning Course
date: '2018-04-25 08:30:13'
tags:
- hacker
---

Note: This is a repost from my [other blog](https://ftrsn.net).

I was originally going to write this as a “review”, but this course is now considered such a foundational resource that writing a review would feel presumptuous and redundant. Then I was going to write it as a list of pros and cons, but I came to the conclusion that this would probably be subjective. So instead I’m writing a set of notes to be interpreted by the reader.

I originally started the [Udacity](https://eu.udacity.com) [Introduction to Machine Learning](https://eu.udacity.com/course/intro-to-machine-learning--ud120) course in preference to [Coursera’s](http://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.4&type=4&subid=0) Stanford University [Machine Learning](https://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.248&type=3&subid=0) course[^1], for reasons which I’ll come to. As for why I switched, I’ll come to that as well. I’ll use the Udacity course as a point of comparison throughout. Please note, though, that I’ve only followed the first 4 weeks of the Udacity course.

## Teachers

The Coursera course is taught by [Andrew Ng](https://en.m.wikipedia.org/wiki/Andrew_Ng), Professor at Stanford University, former chief scientist at [Baidu](https://en.m.wikipedia.org/wiki/Baidu) and co-founder of the following things:

* [Google Brain](https://research.google.com/teams/brain/);
* [deeplearning.ai](https://www.deeplearning.ai);
* [Coursera](https://www.coursera.org) itself.

Needless to say he, he knows his stuff. He also delivers it in a very direct, understandable and sometimes self affacing manner.

The Udacity Course is taught by [Sebastian Thrun](https://en.m.wikipedia.org/wiki/Sebastian_Thrun) and Katie Malone. Sebastian Thrun is also a Professor at Stanford University, as well as Georgia Tech. He led the team which won the [DARPA Grand Challenge](https://en.m.wikipedia.org/wiki/DARPA_Grand_Challenge) in 2005. He also co-founded:

* [Google X](https://x.company);
* The self driving car project within Google X which became [Waymo](https://waymo.com);
* [Udacity](https://www.udacity.com) itself.

Katie Malone is currently the Director of Data Science Research and Development at Civis Analytics. A Stanford PhD, she was an intern at Udacity when the Intro to ML course was made (I think). She handles around 70% of the teaching in the course. 

At the time I started the course, I had not heard of Andrew Ng, but was very aware of Sebastian Thrun. So that was (at the time) a point in favour of the Udacity course.

Looking back now that I know more about Ng, I’d say it’s quite hard to pick who has the more impressive CV. It feels[^2] as though Andrew Ng is a little more respected in the machine learning field, however.

## Teaching Method

The teaching method of the Coursera course is a fairly direct conversion of a standard in-person lecture. Ng talks directly to the camera, or talks while digitally annotating his lecture slides.

The Udacity course plays with the format much more. Having two course leads means that there can be dialogue between them. Sections of some lectures are delivered from inside a self driving car. The leads also joke with each other at times. Making fun of each other’s taste in music, for example, as part of the explanation of a music recommendation system.

Your mileage may vary regarding which of these teaching methods works best for you. I found those used in the Udacity course to be more engaging. It felt as though it used more of the potential of an online course than the approach  the Coursera course takes. At no point in the Coursera course does Andrew Ng sing “Let It Go”. I’ll let you decide whether this is a positive or a negative.

That said, I think I retained more of the knowledge from the Coursera course, so perhaps its explanations were clearer. I suspect it also has a lot to do with the next point.

## Coding Assignments

The Udacity course uses [Python](https://www.python.org) as its teaching language. The Coursera course uses [Matlab](https://www.mathworks.com/products/matlab.html)/[Octave](https://www.gnu.org/software/octave/).

Superficially, this is a huge point in the favour of the Udacity course. Python is essentially *the* language of machine learning at this point. It also has a much bigger ecosystem surrounding it[^3].

For me, at the time, that was enough to make me choose to move forward with the Udacity course.

When I revisited the Coursera course I realised that there’s another significant difference. The Udacity course imports its implementations of the various algorithms from [SciKit Learn](http://scikit-learn.org/stable/). Most of your work in the first three assignments is to initialise the correct class from the library, set it training on the data, and wait. 

For the Coursera course, on the other hand, you implement almost everything from scratch. As a result, you learn more about how the algorithms actually work.

In real world use the first methodology makes a lot of sense. There’s no need to reinvent the wheel. For educational purposes I think it’s preferable to learn the lower level nuts and bolts of the algorithms. Even if the choice of language and programming environment is somewhat... suboptimal, in my opinion[^4].

One further difference: the datasets are much larger in the Udacity assignments. Depending on how powerful the machine you’re using is, it might take 15 minutes or so to finish training the models for the assigments. You’ll also need to download a roughly 4GB zip with the data before starting the first assignment.

## Course Content

The Udacity course is 10 weeks long, where as the Coursera course is 16 weeks. That being the case, clearly the latter has more than 50% more room for content. Even so, the Udacity course teaches several shallow learning methods[^5] which are not present in the Coursera course. The breadth of a Coursera course is much larger, however, and it’s the only one of the two which covers neural networks[^6].

You can read the syllabus of both courses before enrolling, so it’s easy to see whether a particular technology of interest is present.

## Prerequisites 

In both cases, I would say that some programming experience is needed. Both Python and Matlab/Octave are reasonably easy to pick up, though. Based on the assignments I finished, the Udacity course requires the least actual programming.

Please note: If your machine learning needs are limited to training and deploying existing models, you might only need to learn a bare minimum of coding in order to do so.

## What’s Next?

This course was the first part of a syllabus I built for myself when I started trying to skill up on machine learning. It wasn’t part of my original plan, but Andrew Ng released his new [Deep Learning Specialisation](https://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.278&type=3&subid=0) on Coursera just as I was finishing the last few weeks of his Machine Learning course. That seemed somewhat serendipitous, so that’s what I’m working on now. I’ll write a similar set of notes on that course after I’ve finished.

After that I plan to follow both of [fast.ai](www.fast.ai)’s deep learning courses. And after that I’m planning on following the [Philosophy of Mind](https://www.thegreatcourses.com/courses/philosophy-of-mind-brains-consciousness-and-thinking-machines.html) Series from the [Great Courses](https://www.thegreatcourses.com). I might also finish up the Udacity Machine Learning course to help fill in the gaps in my shallow learning knowledge. That said: No battle plan survives contact with the enemy[^7], so I guess I’ll see.

On an entirely different strand of learning, I’m also following the Princeton University [Bitcoin and Cryptocurrency](https://www.coursera.org/learn/cryptocurrency) course on Coursera.

[Discuss this post on Hacker News.](https://news.ycombinator.com/item?id=16353829)

[^1]:	Which tends to get referred to as “The Andrew Ng Machine Learning Course”, hence the title of this piece.

[^2]:	To me, at least.

[^3]:	It also numbers its arrays from zero, just like God intended.

[^4]:	Matlab/Octave is not an environment you’re likely to use in production. It also numbers arrays from 1, where most other programming languages number from 0 (as I noted before). This difference can definitely lead to bugs if you’re not careful.

[^5]:	Such as [Naive Bayes](https://en.m.wikipedia.org/wiki/Naive_Bayes_classifier) and [Decision Trees](https://en.m.wikipedia.org/wiki/Decision_tree).

[^6]:	Which is probably what you’re interested in if you’re starting a machine learning education today.

[^7]:	Or “everyone has a plan until they get punched in the face”, if you prefer Mike Tyson’s trainer’s version.