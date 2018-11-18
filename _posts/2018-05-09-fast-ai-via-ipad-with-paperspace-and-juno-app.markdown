---
layout: post
title: Fast.ai via iPad with Paperspace and Juno App
date: '2018-05-09 12:00:00'
tags:
- hacker
---

Note: This is a repost from my [other blog](https://ftrsn.net).

Having started Fast.ai’s [Practical Deep Learning for Coders](http://course.fast.ai) course, the first thing I noticed is how much less structured it is than Andrew Ng’s [Coursera Deep Learning Specialization](https://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.278&type=3&subid=0) ([non affiliate link](https://www.coursera.org/specializations/deep-learning)).

Fast.ai supplies you with the [Jupyter](http://jupyter.org) notebooks needed for the assignments, but here a lot of the setup is down to you. At first I was a little frustrated by the extra work that Fast.ai was making me do. Then I came to the conclusion that it’s actually a good thing. In the first instance, the less controlled environment is better preparation for actual problems.

In the second, it means I can try doing the whole course via iPad. I’ve already [noted](https://ftrsn.net/2018/03/17/some-notes-on-courseras-andrew-ng-deep-learning-speciality/) that Jupyter in the browser is a pretty miserable experience on iPad. Happily there’s an excellent native Jupyter app called [Juno](https://itunes.apple.com/gb/app/id1315744137?at=1010lLbq), which solves that problem nicely. But a bit of extra work is needed to get it working well.

I decided to use [Paperspace](https://www.paperspace.com/&R=AAGWLUH)[^1] (Fast.ai’s recommended option) as my GPU cloud for this course. There are instructions for setting up Paperspace for fast.ai [here](https://github.com/reshamas/fastai_deeplearn_part1/blob/master/tools/paperspace.md). Once you’ve done that, your workflow will look something like this:

1. Start your instance via the Paperspace console;
2. Log in via ssh and start Jupytor;
3. Copy the URL with the magic token;
4. Paste it into your browser, replacing `localhost` with your instance’s public IP;
5. *Hack hack hack*;
6. Shut down your instance via the Paperspace console.

Step 3 and 4 don’t work so well for Juno, and step 2 is also pretty superfluous. We can eliminate these by turning on password authentication and automatically starting Jupyter on boot.

Password authentication comes first, which will make connecting via Juno a lot easier. I’m assuming you’ve followed the setup I linked to above. Start your instance and log in via the terminal. Now run this on the commend line:

	cd fastai
	jupyter notebook password

Then give it your chosen password. Next: run Jupyter on startup. Type this on the command line:

	crontab -e

Now add this to the bottom of the file which opens:

	@reboot cd /fastai; source /.bashrc; /anaconda3/envs/fastai/bin/jupyter notebook >>/cronrun.log 2>&1

Even though Jupyter will now start automatically, there are still reasons to log in. You’re going to need to download additional datasets, for one thing. `ssh` would be the usual means of doing so, but from the iPad `mosh` (short for [“Mobile Shell”](https://mosh.org)) is a more robust option. I’m using an app called [Blink](http://www.blink.sh) for that.

Paperspace machines are not set up to allow the ports mosh uses by default. So you’ll need to open one, like so:

	sudo ufw allow 60001

After that mosh should work just fine.

[^1]:	That’s an affiliate link which will get you $10 of credit. If you prefer a non-affiliate link there’s one [here](https://www.paperspace.com). If you go that route and still want the $10 credit, you can use my code, which is: AAGWLUH.