---
author: harveynick
date: '2010-10-22 12:09:33'
layout: post
slug: now-in-eye-popping-3d
status: publish
title: Now In Eye Popping 3D!
wordpress_id: '379'
categories:
- Hacker
tags:
- Clockwork Aphid
---

It took a little bit of fighting with bugs that weren't showing up in the 2D view, and a bit of time to figure out what was going on with the lighting system in [JME], but I finally got the 3D display of the [fractal] [landscapes] working.  

[JME]: http://www.jmonkeyengine.org/
[fractal]: http://harveynick.wordpress.com/2010/10/19/youre-speaking-my-landscape-baby/
[landscapes]: http://harveynick.wordpress.com/2010/10/20/some-random-landscapes/

The first stage was just displaying each node as a discrete point so I could see that each was in about the right place. It looks a little bit like this:  

<!-- more -->

{% img center http://harveynick.files.wordpress.com/2010/10/simplegamescreenshot.png %}  

I did this by simply piping the spatial coordinates and colour information of each node into a pair of standard Java [FloatBuffers], passing these to a JME Point class (which should really be called PointSet, in my opinion) and attaching this to the root display node of my JME [application]. The colouring scheme is the same as the one used for the 2D display. Some things don't look quite right, largely due to the fact that I've just drawn the "underwater" points as blue, rather than adding any actual "water." Don't fret, it's on the todo list. 

[FloatBuffers]: http://download.oracle.com/javase/1.4.2/docs/api/java/nio/FloatBuffer.html
[application]: http://bitbucket.org/harveynick/clockworkaphidjava/src/tip/src/com/clockworkaphid/display/threedimensional/PointDisplay.java

That said, the landscape looks about right. All the points seem to be in their correct location. As a quick implementation note, I'm defining the `(x, y, z)` coordinates of the scene in the following way: 

{% codeblock lang:java %}
x = east  
y = altitude  
z = -north
{% endcodeblock %}

With some scaling factors used to map the values from the `[0,1]` range used to address them to slightly more real world like dimensions.  

The next stage was to display the landscape in wireframe to make sure the connections I'll be using create a more solid looking polygon based display are all working correctly. Why not just go directly to polygons? You can see the the detail better in the wireframe display, making debugging much easier. I'll definitely be using it again later.  

This time, instead of piping each and every node into the vertex array, only the nodes at the highest level of detail are used. These are the nodes generated during the final "square stage" of the fractal algorithm, for those of you playing at home. Each draws a triangle (consisting of three separate lines) into the vertex buffer for each pair of parents it has in the landscape. The result looks something like this:  

{% img center http://harveynick.files.wordpress.com/2010/10/simplegamescreenshot2-e1287747142352.png %}

Everything seems to be in good order there, I think. One or two things don't look quite right, particularly the beaches, but the tessellation and coverage of the polygons looks right. Here's a closer in look at some of the polygons so you can see what the tessellation scheme actually produces:

{% img center http://harveynick.files.wordpress.com/2010/10/simplegamescreenshot4.png %}

You can (hopefully) see that each of the "active" nodes sits at the centre of a diamond formed from the shape of its parents, so it's the points with four lines branching from them (rather than eight) which are actually being used to draw the scene.  

Next: polygons. Again, only the nodes at the highest level of detail are used. This time, each inserts itself into the vertex buffer, then adds its parents if they're not in there already. Each node remembers its postion in the vertex buffer, and these indices are then used to draw the actual polygons. These are declared by passing the indices in sets of three into a standard Java [IntBuffer]. The buffers are then passed to one of JME TriMesh geometry classes and displayed, like this:  

[IntBuffer]: http://download.oracle.com/javase/1.4.2/docs/api/java/nio/IntBuffer.html
  
{% img center http://harveynick.files.wordpress.com/2010/10/simplegamescreenshot1.png %}

Again, the beaches don't look quite right, but otherwise I'm reasonably pleased. I still need to add the actual water and improve the form of the landscape itself (and about a million other things), but in terms of display this is looking pretty good. Except for one thing: I'm using far more detail than I need to. Let me illustrate this with a slightly more extreme example. The pictures I've posed so far were generated using seven iterations of the diamond square algorithm. Here's what happens when I use ten iterations (remember, the number of points increases exponentially):  

{% img center http://harveynick.files.wordpress.com/2010/10/simplegamescreenshot5-e1287704750521.png %}

On the bright side the beaches look better, but that's a lot of polygons. Far more then we actually need to display. 1579008 polygons, in fact. We need to reduce that somewhat, if we're going to make things more complicated _and_ maintain a reasonable frame rate (I'm getting about 60fps with this view at the moment). You can see the problem more clearly if I show you the same view using lines rather than polygons:  

{% img center http://harveynick.files.wordpress.com/2010/10/simplegamescreenshot6-e1287704836984.png %}

You can just about see the individual triangles up close, but further away the lines just mush together. I think we can afford to reduce the level of detail as we get further away, don't you?  

Well, I'll get right on that, then...
