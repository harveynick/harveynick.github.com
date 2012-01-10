---
author: harveynick
date: '2010-10-20 15:50:46'
layout: post
slug: some-random-landscapes
status: publish
title: Some Random Landscapes
wordpress_id: '369'
categories:
- Implementation
- Hacker
tags:
- Clockwork Aphid
---

I don't have any 3D views of the [fractal landscapes I've been making] to show you yet, as I'm still working through the different implementation options. I did get a little distracted with the 2D views of the landscape this morning, though, and play with the colouring scheme.

[fractal landscapes I've been making]: http://harveynick.com/blog/2010/10/19/youre-speaking-my-landscape-baby/

<!-- more -->

First of all, let's start again with the example landscape used in yesterday's post, only with slightly more sober colours and a bar on the right showing how the height values map to actual colours:  

{% img center http://harveynick.files.wordpress.com/2010/10/image5.png %}

Now that looks reasonably neat already, in a "my first atlas" kind of way, but clearly there's a lot of information missing. We can see this if I plot the height values in monochrome, giving the landscape a more "plasma cloud" appearance:  

{% img center http://harveynick.files.wordpress.com/2010/10/image6.png %}

Now we can see the extra information, but we've lost a lot of the sense that what we're looking at is a landscape. It looks more like a cloud. We can get some of that back by combining the two approaches and using different shades of blue and green:  

{% img center http://harveynick.files.wordpress.com/2010/10/image7.png %}

Now this looks a lot better. I think the water looks quite reasonable using this scheme, but the landscape is a bit... homogenous. Is every part of the land covered in grass? How boring!  

We can make things a bit more interesting by adding a thin band of "sand" around the coast, and some "mountainy" colours (and snow!) higher up, like so:  

{% img center http://harveynick.files.wordpress.com/2010/10/image8.png %}

Now this looks better, the sand in particular. The mountains look okay, but not quite right. Something's a little off. That's not what mountains actually look like. We also don't have any rivers or above sea level lakes. These are problems I'm going to look at later, after I get a reasonable 3D display system working. In the mean time, though, here are a couple more 2D landscapes for your viewing pleasure: 

{% img center http://harveynick.files.wordpress.com/2010/10/image9.png %}

{% img center http://harveynick.files.wordpress.com/2010/10/image10.png %}
