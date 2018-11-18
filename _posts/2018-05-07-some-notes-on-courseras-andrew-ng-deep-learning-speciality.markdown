---
layout: post
title: Some Notes on Coursera’s Andrew Ng Deep Learning Speciality
date: '2018-05-07 12:00:00'
tags:
- hacker
---

Note: This is a repost from my [other blog](https://ftrsn.net).

As with my [previous post](https://ftrsn.net/2018/02/11/some-notes-on-the-andrew-ng-coursera-machine-learning-course/) on [Coursera’s headline Machine Learning](https://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.248&type=3&subid=0) course, this is a set of observations rather than an explicit “review”. There’s a heavy dose of “your mileage may vary” here. I’m aiming to lay out a set of objective observations about the course to help the reader decide if the course will be useful to them. That said: There will be opinions here.

I’ll be using that same ML course as a reference for comparisons. I’ll also make a comparison to the Udacity [“Introduction to Machine Learning”](https://eu.udacity.com/course/intro-to-machine-learning--ud120) course I mentioned in the previous post. That’s a lot of “learning”, so I’ll be using the following acronyms to help maintain my sanity:

* **CML** - [Andrew Ng](https://en.m.wikipedia.org/wiki/Andrew_Ng)’s [Coursera Machine Learning](https://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.248&type=3&subid=0) course, originally taught at Stanford University;
* **UIML** - Sebastian Thrun and Katie Malone’s [Udacity Introduction to Machine Learning course](https://eu.udacity.com/course/intro-to-machine-learning--ud120);
* **CDLS** - The [Coursera Deep Learning Speciality](https://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.278&type=3&subid=0) by Andrew Ng’s [DeepLearning.ai](https://www.deeplearning.ai). i.e. The subject of this post.

If at any point I’m talking about a course but haven’t specified which: assume it’s **CDLS**.

## Cost

Let’s get this out of the way first. Where as **CML** could be fully “audited” for free, **CDLS** cannot. To be clear: you can get just about everything out of **CML**, including grading of assignments, without having to pay a penny to Coursera. If, at the end of the course, you want a digital certificate: that will cost you £60. But if you don’t care about that, you don’t have to spend the money[^1].

**CDLS**, on the other hand, is subscription based. At the time of writing it costs £37 per month. You can watch at least some of the lectures without paying that, but you can’t do any of the coding assignments or access the course forums. The charge is fair enough, in my opinion. The content is new, and you’re learning from a master. This course requires more support resources than **CML**, as well. I’ll get to that in the “Coding Assignments” section. In fairness, it’s also a business, not a charity.

## Course Content

The specialisation is actually made up of five separate courses. In order, these are:

1. *Neural Networks and Deep Learning* (4 weeks);
2. *Improving Deep Neural Networks: Hyperparameter Tuning, Regularisation and Optimisation* (3 weeks);
3. *Structuring Deep Learning Projects* (2 weeks);
4. *Convolutional Neural Networks*, aka image processing (4 weeks);
5. *Sequence Models*, aka language processing (3 weeks).

You can choose to take them in any order, or to skip any you’re not interested in. Each builds on those before[^2], though, so my advice would be to take each course in the specified order. The length of each course in weeks is really just a guidance figure. Each “week” is actually a little under 2 hours of video lectures, plus graded assignments. You can take it as quickly or slowly as you like[^3].

The first three weeks of the first course overlap quite heavily with the parts of **CML** which teach neutral networks. The third course also has some crossover with the sixth (*Advice for Applying Machine Learning* and *Machine Learning System Design*) and tenth (*Large Scale Machine Learning*) weeks of **CML**. The material has been updated, however, and made more applicable to deep neural networks.

## Teaching Method

The teaching methodology is basically identical to **CML**. Ng talks to the camera, or he talks whilst annotating slides. It is, again, a pretty direct conversion from an in person classroom lecture to video format. There are a couple of exceptions to this in the main lectures, which show Ng interacting with an implemented system.

The other exception to this format are the optional “heroes of deep learning” interviews which are included at the end of five of the lectures in the first two courses.  The subjects of the interviews are: Geoffrey Hinton, Pieter Abbeel, Ian Goodfellow, Yoshua Bengio, and Yuanqing Lin. In my opinion the Hinton interview is the one most worth your time.

Again as with **CML**, each week’s lecture is broken down into more focussed individual videos of between 5 to 15 minutes.

I have to mention the first quality issue here. In some places it’s actually really badly edited. Ng sometimes makes false starts and begins again. At first I though the video was skipping, but then I noticed small changes in what Ng said at the times he repeated himself. This happens about once a video, on average. There are also occasional long pauses in the dialog, suggesting that Ng has lost his place in his notes. I find it pretty baffling that these glitches haven’t been edited out. Hopefully it’ll get fixed in an update to the course at some point.

Alongside the videos are the graded assignments. Every week there is a quiz, usually with 10 to 15 questions. A score of 80% or higher is required to pass, but you’re allowed to retake the quiz if you initially get some of the questions wrong. Most weeks also have coding assignments. This isn’t true of the very first week, which serves as an introduction. Nor is it true of the third course, *Structuring Deep Learning Projects*. This is assessed with longer quizzes, which it calls “machine learning flight simulators”.

Editing issues aside, the teaching worked really well for me. In particular, I feel like I came out of the sequence models course with a level of understanding I’ve failed to get from other sources.

## Coding Assignments

The coding assignments are something I feel **CDLS** really gets right. To recap, both **CML** and **UIML** have you download datasets and outline code. You modify the code locally, run it to make sure it works, and then either submit it for online assessment or answer questions about its output. **CML** has you code (almost) everything from scratch using [Matlab](https://www.mathworks.com/products/matlab.html)/[Octave](https://www.gnu.org/software/octave/). For **UIML** you use [Python](https://www.python.org), and mostly parameterise library implementations of the relevant algorithms from [SciKit Learn.](http://scikit-learn.org/stable/)

**CDLS** uses the best parts of both of these approaches, in my opinion. The teaching language is Python. You begin in the first course by coding neural networks and optimisation algorithms completely from scratch. This is done using [NumPy](http://www.numpy.org), which essentially adds most of the numerical computing features of Matlab/Octave to Python. The second course then introduces [TensorFlow](https://www.tensorflow.org), a much higher level framework which does a lot of the work for you. Later in the fourth course, [Keras](https://keras.io) (an even higher level framework) is introduced and used. Still, even during the later assignments you might occasionally use NumPy when it makes sense to teach you about an algorithm or technique.

Rather than having you download the code and run it locally, **CDLS** instead uses [Jupyter Notebooks](http://jupyter.org) hosted by Coursera. This is a web based IDE, which allows you to code in your browser. It mixes code, blocks of descriptive text, formulas, and images. This makes it an excellent teaching tool. Being browser based, you can also access it from anywhere without needing to download anything[^4]. I actually did one of the assignments from my iPad when I couldn’t use my laptop[^5].

Here, unfortunately, I also need to mention another quality issue. Two of the assignments in the last course had incorrect “expected output” values. The upshot of which was that I spent over an hour in total trying to figure out how to “fix” my code, when it was actually working perfectly. In both cases I eventually discovered “errata” forum posts detailing the issue. I guess the lesson here is: always check the forums first. Again: it’s pretty frustrating that this hasn’t been fixed in the notebook and I needed to refer to the forum at all.

It’s worth noting here that server time isn’t free. Running the Jupytor notebooks for the coding assignments is one of the things your £37 a month[^6] is paying for.

I do have a small complaint about the specifics of that server time, though: it’s running on CPU instances. This means that training times are much longer than they would be on a GPU instance. In the earlier courses this means you might need to occupy yourself for 15 minutes whilst your network trains. In the later courses training just becomes infeasible and you work with pre-trained models instead. I can only assume that using GPU instances would make the course prohibitively expensive, either for the user or Coursera themselves.

## Prerequisites

Going into this course, you should already have some experience of coding in Python. Fortunately Python is an easy language to pick up. [HackerRank](https://www.hackerrank.com/) is my favourite “coding dojo” for when I need to skill up on a new programming language. I think their “30 days of code” challenge is probably a good place to start for someone new to coding.

Additionally, I would recommend doing the **CML** course first. It’s not all directly relevant, but will give you some good intuition and background. For example: when Ng using the phrase “large margin classifier” in CDLS, you’ll know exactly what he’s talking about right away.

## What’s Next

Broadly I’m sticking to the plan I wrote at the end of my write up of **CML**. Next: Fast.ai’s [Practical Deep Learning for Coders](http://course.fast.ai).

[^1]:	For the record, I did spend the money. In the first instance: curiosity about what the certificate would actually be. In the second: I thought the course was great and felt Coursera had earned the money.

[^2]:	To a greater or lesser extent. The earlier courses are quite foundational, the latter ones less so. That said: you will miss some nuiance in the Sequence Models course if you skip Convolutional Neural Networks, for example.

[^3]:	Though if you take it too slowly the system will by default start to bug you with notifications and emails.

[^4]:	Aside from the content of the web page. Obviously. You know what I mean.

[^5]:	I don’t recommend that, though. Jupytor breaks the inertial scrolling in mobile safari, which can make it pretty frustrating to use. 

[^6]:	Or local equivalent.