---
title: Lapped by Fast.ai
tags: 
  - hacker
category: "Relearning Machine Learning"
layout: post
image: /assets/img/2019-02-19-lapped-by-fastai/Image%2017-02-2019,%2012-09.jpeg
feature_image: /assets/img/2019-02-19-lapped-by-fastai/Image%2017-02-2019,%2012-09.jpeg
---


Well. This is embarrassing.

At the beginning of last year I was working my way through fast.ai’s excellent [Deep Learning for Coders](http://course18.fast.ai) course. Then, around the time I was due to start the last module, my life got very busy and complicated. To be clear: it got very busy and very complicated, but in a very good way. More about that in a future post. Nevertheless, it didn’t leave me a lot of time or mental bandwidth for my machine learning studies.

At the beginning of *this* year I was contemplating picking the course back up, and trying to figure out how much of the previous material I would have to review. Exciting things have been happening recently. DeepMind have gotten some very [interesting results](https://deepmind.com/blog/alphastar-mastering-real-time-strategy-game-starcraft-ii/) with their StarCraft II playing AI, for example.

But right about the same the same time, fast.ai [launched](https://www.fast.ai/2019/01/24/course-v3/) the updated 2019 version of their course. I have been lapped.

So. I’ve decided to just start the new course from scratch. Reading through the introductory post (and the [comments on Hacker News](https://news.ycombinator.com/item?id=19000027)), it sounds like there’s plenty of new material in there. Hopefully they’ve also rounded out some of the rough edges in how the content is laid out, and in the fast.ai library which goes with the course[^1].

Previously I used a Paperspace VM instance for running the exercises. Now that [Paperspace’s Gradient](https://www.paperspace.com/gradient) platform appears to be fully up and running, I’m going to give that a try. I’m hoping it’ll simplify using [Jupyter Notebooks](https://jupyter.org), which is my main use case. It seems that it also lets you switch instance types between runs. There are some tasks which the GPU can’t help with, such as:

* Downloading datasets;
* Initial data examination (viewing images etc.);
* Basic data transformation and feature engineering.

It’ll be nice not to have to pay for a GPU when doing them.

That said: If at all possible I’m going to try using the new [Jupyter Lab](https://blog.jupyter.org/jupyterlab-is-ready-for-users-5a6f039b8906), rather than plain Jupytor Notebooks. Jupyter Notebooks are awesome, but I have one huge frustration with them: they use the browser for some computation related to updating the the notebook document itself. This means that if your computer goes to sleep or the browser crashes three hours into a four hour training run you might lose a portion of the data. Jupytor Labs does it all on the backend. You can set your job running and go about your business.

Failing that (or possibly in concert with it): I’d like to try out Gradient’s support for [container based jobs](https://support.paperspace.com/hc/en-us/articles/115004536033-Jobs-Overview). That seems like a good way to do long lived training. Assuming I can make it resilient to random restarts, it could even use low cost, preemptable instances.

[^1]:	Python’s varargs functionality is very cool and useful, I’ll admit, but using all the way down can be utterly infuriating.
