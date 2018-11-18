---
layout: post
title: Fractal Errata
date: '2010-10-22 15:41:33'
tags:
- hacker
---

Some of the particularly sharp/anal ones amongst you might have noticed that while the technique for generating fractal lanscapes I [previously described] works (and works well), it's not 100% _correct_. Specifically, the fact that it uses the the same scaling factor for nodes created by the diamond and square steps isn't quite right.  

[previously described]: /2010/10/19/youre-speaking-my-landscape-baby

<!-- More -->

Why is this? Because they generate nodes which adhere to different levels of detail, that's why. Lets go back to that last diagram from the post which described the algorithm:

![](http://harveynick.files.wordpress.com/2010/10/fractallandscape9.png)

Now while you'll note that both steps add nodes that can be addressed using fractions with two as their denominator, the distance of the nodes created by the diamond step to their parents is greater than those created by the square step.  

The nodes created by the square step are orthogonal to their parents, so the distance between them is proportional to a half, which as luck would have it has the same as the denominator as the fractions used to address the node. How convenient!  

The nodes created by the diagonal step, on the other hand, are diagonal to their parents. This means that the distance to their parents is the pythagorean root of this same distance, so in this specific case: 

```
sqrt(½\*½+½\*½) = sqrt(¼+¼) = sqrt(½) = something
```

Once again, the key fraction used to work this out has the same denominator as those used to address the node in the landscape. Thus, if d is equal to the denominator we're using to address a node, the basic scaling factor used to offset a new node from its parents would be the following: 

```
if (diamond step)
  range = [-sqrt(1/d * 1/d * 2), sqrt(1/d * 1/d * 2)]  
else
  range = [-1/d, 1/d]
```

As I said before, this won't make a lot of difference, but it will be more correct and that's important to some people. Myself included.  

For comparison purposes this is the effect this change has on the example landscape I've been using. The original landscape looks like this: 

![](http://harveynick.files.wordpress.com/2010/10/image8.png) 

The updated landscape looks like this:

![](http://harveynick.files.wordpress.com/2010/10/image11.png)

There's some difference visible, but not a huge amount. Mostly, it's just increased the range the data are occupying and expanded the bell curve accordingly. Hence, more high points and more low points, but the land is the same basic shape.
