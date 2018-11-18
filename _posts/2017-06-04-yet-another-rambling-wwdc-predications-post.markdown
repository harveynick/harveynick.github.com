---
layout: post
title: Yet Another Rambling WWDC Predications Post
date: '2017-06-04 22:38:50'
tags:
- hacker
- geek
---

Tomorrow is the opening keynote of Apple's WWDC[^1] conference. Two years ago I predicted that Apple would open source Swift, and I was right[^2]. Last year my predication was [XCode] for iPad. That didn't happen, but [Swift Playgrounds] did… which sort of made me half right. Rather than just tweet one prediction this year, I figured I'd try writing a whole post on the subject. Does the internet need another one of these? No, it almost certainly doesn't. But it's fun to write about, so I'm going to anyway. Also worth noting: many of these predications are stolen from other people, whom I've tried cite where possible.

[XCode]: https://developer.apple.com/xcode/
[Swift Playgrounds]: https://www.apple.com/uk/swift/playgrounds/

A few days before the WWDC kickoff, Apple [announced] integration between Swift playgrounds and various robotic toys. I think this is huge. Firstly from the perspective of teaching children to code. Kids are going to go *nuts* for this. I can see this selling a lot of iPads to education programs, and a *lot* of these toys to the kids in those programs. Secondly: this looks like an absolute blast to *me*, an adult software engineer. I've been wanting to play with an autonomous drone for a while, and this would be a great place to start.

[announced]: https://www.apple.com/newsroom/2017/06/swift-playgrounds-expands-coding-education-to-robots-drones-and-musical-instruments/

The fact that this was announced *before* WWDC even starts makes me wonder what *is* in the keynote such that this didn't make the cut. It would have been such a good onstage demo that I find it hard to believe that they don't have something similar, but better, to show us. So here's my first predication: that this is part 1 of something bigger and we'll see that on stage.

On the other hand, remember the iPhone controlled model cars from a few years ago? That went down like a lead balloon, so maybe Apple didn't want to chance a demo of something similar.

Regardless of the above, I think they'll definitely be announcing something related to the [Swift programming language], which is now due close to hitting v4. It seems to have a pretty good uptake for server side coding, so perhaps they'll have some numbers for that and maybe a big partner like [IBM] on stage to talk about it.

[Swift programming language]: https://swift.org
[IBM]: https://developer.ibm.com/swift/

I half suspect they might announce something related to Swift in the browser, but on balance that might be a step too far. Apple doesn't have enough clout in the browser market to make that work, and if it was Safari only that would be getting dangerously close to Microsoft's old bad habits.

Some real genuine love for XCode on stage would be a really good thing. I actually like using it, but there's no denying it has issues. I regularly lose syntax highlighting and code completion when I'm working, for example. My predication here is a fully sanctioned extension API so other developers can add new functionality. Maybe even a (hopefully optional) App Store.

I'm also still hopeful for a beefed up version of Swift Playgrounds which brings it closer to being a fully fledged XCode for iPad.

Two other things which need some love are the iPad itself, and Apple's pro users. The former hasn't had anything really new introduced since [iOS 9] two years ago, and the latter feel a little burned by Apple's lack of updates to its "pro" hardware.

[iOS 9]: https://en.wikipedia.org/wiki/IOS_9#Multitasking

The usual meaning of "pro users" in this context are people who need a big honking powerful machine and the right software in order to get their jobs done. We're talking professional photographers, video editors, animators, etc. When you're in this line of work you need something like a mac pro (which hasn't been updated since 2013(!)) or one of the older, heavier, more powerful MacBook Pros which Apple all but phased out with the last refresh.

One thing apple could do to try and appease these users would be to put more effort into positioning the iPad Pro as a machine they could genuinely use for work. They could, for example, demo a serious pro app on stage. My guess would be Affinity Photo for iPad, which Serif previously [demoed offstage at WWDC in 2016], but has been very quiet about ever since.

[demoed offstage at WWDC in 2016]: https://petapixel.com/2016/06/14/sneak-peek-affinity-photo-ipad/

The possibility of a [new 10.5" iPad Pro] has been floating around for what seems like forever at this point. It about half makes sense to me, I think. I'm not prepared to actually make any predictions about it, though.

[new 10.5" iPad Pro]: https://9to5mac.com/2017/06/02/10-5-inch-ipad-pro-anker/

Speaking of the iPad, the team at MacStories created a fantastic [iOS 11 wish list concept video], and I agree with pretty much all of it. The existing multitasking model on the iPad actually works really well, but it's badly in need of a better app switcher. I'd also really love the drag and drop system they suggest. It's certainly technically possible, [Readdle] have already implemented [something very similar], but only between their own apps. So what the hell, I predict that MacStories are right about these things. 

[iOS 11 wish list concept video]: https://www.macstories.net/stories/ios-11-ipad-wishes-and-concept-video/ 
[Readdle]: https://readdle.com
[something very similar]: https://blog.readdle.com/drag-drop-between-readdle-apps-fd079c756b23

The rumour of a ["Siri Speaker"] which competes with both Amazon Echo and Sonos is also pretty well trodden. That would make sense, since these devices seem to be kind of a big deal at the moment. If Apple ships one of these I hope it comes along with the also rumoured ["Siri 2"], because the current iteration probably wouldn't cut it. It's also not much of a demo without a much improved Siri, given that demoing Siri on a phone and demoing it on speaker don't look that different when you're showing it to an audience.

["Siri Speaker"]: https://arstechnica.co.uk/apple/2017/06/apple-alexa-competitor-siri-speaker/
["Siri 2"]: https://www.macrumors.com/2017/01/24/apple-enhanced-siri-iphones/
 
I'm actually hoping this isn't a Sonos competitor, because I already have a Sonos system I'm very happy with and don't feel like I need an alternative. A more privacy conscious Amazon Echo competitor, though? [That's something I can get behind].

[That's something I can get behind]: http://harveynick.com/2017/05/07/untitled/
 
If they talk about Siri they might also talk about some of the machine learning tech which I assume is behind it. Last year when they demoed the new image recognition tech for Photos apps in iOS10 and macOS Sierra they touched on this. In particular they talked about ["differential privacy"], a way of training their classifiers on user data, without needing to actually expose any of the that data and potentially the user's privacy with it. Apple also allowed their machine learning researchers to [start publishing their work] in the last year. This was news because it's surprising for a such a secretive company. It's a good move because it makes Apple more appealing place to do machine learning research. Maybe they'll talk about some of their publications in this field and reveal some of the other work they're doing. We might also get some more talk on the intersection of machine learning and privacy. Perhaps also some direct machine leaning APIs will be exposed in iOS 11?

["differential privacy"]: https://en.wikipedia.org/wiki/Differential_privacy
[start publishing their work]: https://www.macrumors.com/2016/12/26/apples-ai-team-first-paper/

My last, slightly wild, prediction is multi-device apps. I'm willing to bet a lot of iPad users also have an iPhone. Others might have additional iPads (especially if they're crazy people like [CGP Grey or Mike Hurley]). Being able to freely pass data between them, either between instances of the same app or across apps, could let developers do some really interesting things. Again, this could be good for video editors and photographers who need a lot of pixels for examining an image and don't want controls getting in the way. It would create use cases for multiple iDevices, which might lead people to buy more iDevices, which seems like the sort of thing that Apple might be interested in.

[CGP Grey or Mike Hurley]: https://www.reddit.com/r/Cortex/comments/5ytysj/john_siracusas_epic_rant_on_atp_about_cgp_greys/

So in summary, here are my predictions:

1. A more impressive follow up to the integration between Swift Playgrounds and robotic toys;
2. Some Swift related numbers for apps in the store and code on the server, with a big partner on stage;
3. Swift in the browser (huge maybe);
4. Fully sanctioned XCode plugins with an optional app store;
5. More fully featured version of Swift Playgrounds on iPad;
5. Affinity Photo for iPad demo on stage;
6. Better iPad multi-tasking app switcher, plus drag and drop between apps;
7. The Siri speaker, and Siri 2 to make it actually worthwhile;
8. Machine learning at Apple; machine learning and privacy; machine learning APIs in iOS 11; 
9. Multi-device apps.

It occurs to me now that I don't really have any macOS, watchOS, or tvOS specific predications here. I hope we get something about each them, all the same. I just have no idea what.

[^1]: World Wide Developer Christmas.
[^2]: Not exactly an Nostradamus level precognition, but still.