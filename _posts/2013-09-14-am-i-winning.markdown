---
layout: post
title: Some Thoughts on Gamification
date: '2013-09-14 14:01:00'
tags:
- blogger
- bibliophile
- cinephile
- geek
- gym-rat
- globe-trotter
---

If you're playing any sort of a game, the question "Am I winning?" is usually quite easy to answer. "Is my score higher than the other guy?" usually covers it (though if you're playing something like chess it might be a little more complicated than that). If you're playing a computer game the fact that your character is still alive may well be enough to settle this question in your favour.

In life, though, it is a much harder question to answer. It may well be true that, to the healthy mind, it's not something which should ever really matter, but [as noted before], gamification works really (embarrassingly) well for me.

[as noted before]: http://harveynick.com/2013/05/06/do-you-even-lift/

I suspect that deep down most people have their own ways of keeping score. Their bank balance. Their air miles account. How far they ran today. More abstract things, such as their perceived quality of the of the photos they took this weekend, leaning to less abstract things, actual scores, such as might be gleaned from [Fitocracy] or [Foursquare].

[Fitocracy]:https://www.fitocracy.com/
[Foursquare]:https://foursquare.com

<!-- More -->

Life is not a computer game, but even so it's nice to have a way of tracking your progress. I'll say it again: gamification works really well for me. As a result, I found myself looking to games directly for inspiration. If you haven't picked up on this already: this is going to be quite the nerdy blog post. You have been warned.

In a certain kind of game, it's quite common to not only have a single main score (usually called something like "experience points"), but also a set of attributes which describe the capabilities of your character.

If we go right back the main influence for a lot of these sort of games (Dungeons and Dragons, though I'll be drawing from [Pathfinder], a alternative modern implementation) we find six main attributes:

[Pathfinder]:http://paizo.com/pathfinder

* _Strength_ measures muscle and physical power;
* _Dexterity_ measures agility, reflexes, and balance;
* _Constitution_ represents your character's health and stamina;
* _Intelligence_  determines how well your character learns and reasons;
* _Wisdom_ describes a character's willpower, common sense, awareness, and intuition;
* _Charisma_ measures a character's personality, personal magnetism, ability to lead, and appearance.

In Pathfinder you have a score for each of these values, with a (theoretical) maximum of 18, though anything less than 10 is considered very bad. For all intents and purposes your character is born with these scores, chosen semi-randomly using dice, and has very little in the way of opportunity for improving them directly.

Tangent: that last part has always annoyed me. In _D&D_ and _Pathfinder_, doing (for example) strength based activities has no effect on your strength score, and increases in strength have no connection to strength based activities your character may have performed.

That aside, I think these are actually quite good metrics for a person to use when measuring their personal development (or less marketing speak-ey words to that effect). Here are some more buzz words for you (and the Google crawlers): personal analytics, the quantified self. The question then becomes one of measurement.

## Strength

Strength would appear to be the easier to measure directly (and the ones which ties in most easily with many of my other posts). Basically: how much can you lift? We're looking for a single normalised value here, though, not a collection of eight absolute ones (4 "primary" barbell lifts * 2 (weight + repetitions)).

We can transform the eight values into four quite simply using a technique similar to that employed by [Strength Standards] to turn a weight and number of reps into a single theoretical "one rep max". [Wikipedia provides] a wealth of formulas for calculating this.

[Strength Standards]:http://www.strstd.com/
[Wikipedia provides]:http://en.wikipedia.org/wiki/One-repetition_maximum#Calculating_approximate_1RM

So far so good, but we still have four numbers when we need one. Adding them together won't help, since this doesn't take the weight of the individual performing the lifts into account and also assumes that all four values have the same scale. This is categorically not the case. My dead lift max is almost three times that of my shoulder press, but the latter is no less important than the former. Normalisation is required.

The other trick Strength Standards performs is to plot your theoretical one rep max on a scale which starts at "untrained" and tops out at "elite" (which roughly translates to "Olympic Athlete"), with values selected by weight. These also happen to be not unlike those (reluctantly) [laid out by Mark Riptoe].

[laid out by Mark Riptoe]: http://startingstrength.com/files/standards.pdf

That's the key here, I think. If we make "untrained"/"Cat. I" a 10 and "elite"/"Cat. V" an 18 we end up with four normalised values. Average these and: boom. We have our score for strength, I think.

This doesn't completely prevent a decent squat from compensating for a terrible bench press (like in my case), but it does mitigate the effect somewhat. That said: I am prepared to admit that a more fair measure might cap the total at some value measured from the weakest of the four. We'll see. Also, the rate at which this should decay presents an additional complication here, for reasons I'm not going to go into, but might in another post.

The other five values are not as easy as all that. Rather than actually get into the nitty gritty of those here, I'll instead discuss what I think if the right approach and possibly revisit them later.

## Dexterity

Dexterity, I have to confess, has me almost completely flummoxed. How do you measure agility or aim in a way which can actually be reflected in everyday life? If you're a member of a gun or archery club, then problem solved. Maybe. Otherwise I'm not so sure. Likewise, if you study a martial art I think that probably counts as "Dexterity"… but how do you compare [Kendo] to [Krav Maga]?

[Kendo]:http://en.wikipedia.org/wiki/Kendo
[Krav Maga]:http://en.wikipedia.org/wiki/Krav_Maga

## Constitution

Constitution would appear to be a little more straightforward. This is a measure of what your body can take. Have far can you run, cycle or swim? How long does it take you? How many press/chin/pull ups can you do (maybe)? Perhaps even steps taken (I'm looking at you [Fitbit] / [Jawbone Up] / [Nike+ Fuelband] / [Withings Pulse])? What I don't have yet is the metric to fuse this all together.

[Fitbit]:http://www.fitbit.com/uk
[Jawbone Up]:https://jawbone.com/up
[Nike+ Fuelband]:http://www.nike.com/cdp/fuelband/us/en_us/
[Withings Pulse]:http://www.withings.com/en/pulse

## Intelligence

There is, of course, a fairly standard method of measuring intelligence. Dropping in "IQ test" here and saying "job done," would definitely be the simplest solution. For an alternative proposal, though, I will defer to a good friend of mine. Tyrion Lannister.

> “My brother has his sword, King Robert has his warhammer and I have my mind… and a mind needs books as a sword needs a whetstone if it is to keep its edge.”


So then, perhaps this measure could actually relate to rate of reading. Whether this should be measured in terms of books, pages or words I'm not sure yet. These get increasingly accurate… and increasingly faffy[^1] to measure. Another thing to consider is whether all books are created equal. I don't want to get (too) pretentious here, but I'm inclined to consider some books… more beneficial to improving one's mind than others. Yes, I enjoyed the hell out of the Da Vinci Code, and I don't care who knows it, but I was (if anything) less intelligent after I finished reading it.

It's also not clear to me whether this category should include consumption of movies. What about plays? Magazines? Articles on the Web? Perhaps even TV shows (Breaking Bad _yes_, X Factor _no_)?

## Wisdom

Wisdom is quite nebulous as presented here. The willpower part of it would tend suggest some sort of measure of personal discipline. How well you keep to your diet, how consistently you exercise (perhaps this category is where the step trackers fit).

For me, though, wisdom suggests experience and I'm inclined to connect that to travel. On the wall of my flat is a map with pins pushed in for each of the countries (or cities in the case of the big ones) I've visited. This is the sort of thing I'm thinking of. Pins on a map. Stamps in a passport. These are a bit on the analogue side though, and this is the digital age, baby. Besides, EU countries don't stamp my bloody passport anymore. I'm inclined to point towards services such as [Foursquare] and [Fog of World] when it comes to measuring things like this.

[Foursquare]:https://www.fitocracy.com/
[Fog of World]:http://en.fogofworld.com/

The former divvies everything up nicely and gives you lots of other ways of measuring experience ("Your first Korean Restaurant!"), while the latter gives you an actual percentage of the world which you've explored. Obviously this only works if you keep the app running (so say goodbye to your battery life) or manually input tracks from an external GPS (faff!), and is also guaranteed to be a distressingly small number which grows at an almost imperceptible rate.

Again, there is a ghost of the potential for a metric here.

## Charisma

Charisma is similarly nebulous. I refuse to declare this a measure of how sexy a person is. A don't even know how we would go about measuring that anyway (selfies placed on Hot or Not?[^2] Maybe not…). Instead I'd be inclined to make it a counterpart to intelligence, in a similar way that strength is essentially a counterpart to constitution: The first a measure of what you put out, the second a measure of what you take in… and my suggestion for intelligence was a measure of the creative work a person takes in.

So then: I suggest a measure of charisma related to a person's creative output. Words written. Content produced and published. This could be in terms of your blog, the novel you've been working on or that personal coding project. An additional measure for this could be how much others actually engage with the content you produce. In the case of anything web based [Google Analytics] (and similar) make a good way of measuring this, I think. The others would be somewhat harder to measure directly.

[Google Analytics]:http://www.google.com/analytics/

## Lastly

Something you might have noticed here: that first one was quite easy to map onto the Dungeons and Dragons 0-18 scale; the others  not so much. They're much harder to calibrate and, in some cases, quantify. Some might only work as qualitative measures, in fact.

But then, as you might have guessed, I'm really thinking out loud here. These ideas are only half baked, but who doesn't love the smell of half finished baking?

<br/>

[^1]: Perhaps you need to Google this word. Know this: [Urban Dictionary](http://www.urbandictionary.com/define.php?term=faffy) is wrong on every count, at least for the meaning I'm assigning to it. [Collins Online Dictionary](http://www.collinsdictionary.com/submission/2/faffy) gets it spot on.

[^2]: News Flash! [Hot or Not](http://hotornot.com/) is still a thing!