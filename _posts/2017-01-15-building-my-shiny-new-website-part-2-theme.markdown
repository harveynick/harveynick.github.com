---
layout: post
title: 'Building my Shiny New Website Part 2: Theme'
date: '2017-01-15 18:27:00'
tags:
- blogger
---

I built the theme of the previous Jekyll based incarnation of this site myself. If I’m entirely honest I made a bit of hash of it. I just hacked the default Jekyll layout around a bit and slotted in some colours I though might look reasonable. They did not, in practice, look reasonable. Neither did the fonts, the vertical rhythm or just about any other part of it.

This time I resolved that if I was going to build my own theme I was going to start from scratch. If you’re going to fail, you might as well fail big, after all. So I downloaded the most basic [Ghost] theme I could find. We’re talking some seriously 90s visuals here. Links coloured *that* shade of blue, shifting to *that* shade of purple when clicked. If you're too young to remember those shades you make me feel sad. Go look at [Richard Stallman's blog] or something.

[Ghost]: https://ghost.org
[Richard Stallman's blog]: https://stallman.org

## Influences

I started looking at the style (read: the CSS) of websites I really like the design of. I mentioned [Medium.com] before, and that’s a big influence. I love the clean layout and flow that medium pages have. Take [this example] from Casey Johnston’s “Ask a Swole Woman” series. It’s not just solid advice, it’s very cleanly presented. Medium.com's designers are really good.

[Medium.com]: https://medium.com
[this example]: https://thehairpin.com/ask-a-swole-woman-17th-century-whaler-problems-fe10afaaf962#.s6g32kn06

As an aside, I think it's worth mentioning here that this is actually one of the issues with Medium. The site design might be amazing today. Tomorrow, though, it might change to something else which doesn't work for you at all. There's nothing you can do about that. Today your full bleed header images look great. Tomorrow Medium decides it no longer supports them.

Another site I think is worth mentioning is (polarising “[Accidental Tech Podcast]” co-host) [Marco Arment’s Blog]. Not because I think it’s especially pretty (sorry Marco), but because of how clean and simple it is. There’s very little on the page which doesn’t need to be there, and it all loads extremely quickly. It uses few fonts, and a small set of complementary colours. It used to have an ad at the top (which is gone now, it seems), but that came from [The Deck], which produces genuinely attractive ads, so this didn’t end up really taking anything away from it. There are some things I don't love, chief among them being the way it just slaps images in there, without linking them in to the surrounding text.

[Accidental Tech Podcast]: http://atp.fm
[Marco Arment’s Blog]: https://marco.org
[The Deck]: http://decknetwork.net

I could also call upon a few other clean and simple sites here. [Matt Gemmell] and [Casey Liss] also have blogs which are good examples. But the point is this: everything is a remix and nothing exists in a vacuum. You should wear your influences on your sleeve, in my opinion.

[Matt Gemmell]: http://mattgemmell.com
[Casey Liss]: https://www.caseyliss.com

I wasn't drawing from these themes wholesale, though. They're an influence, but I still had to make most of the actual design choices myself.

## Fonts and Colours

I love Adobe’s [Source Code Pro] monospace font[^1], so I knew ahead of time what I wanted to use that for any blocks of code or similar formatting. [Source Serif Pro] (from the same family) pairs very nicely with it, but unfortunately doesn’t have italics, which is *unacceptable* for my purposes. Aping Medium’s style, I did want to use a serif font for body next, so [Source Sans Pro], the third sibling in the family, wouldn’t work. Fortunately [Lora] is a very nice alternative. It also has *gorgeous italics* (look at that "a"!).

[Source Code Pro]: https://fonts.google.com/specimen/Source+Code+Pro
[Source Serif Pro]: https://fonts.google.com/specimen/Source+Serif+Pro
[Source Sans Pro]: https://fonts.google.com/specimen/Source+Sans+Pro
[Lora]: https://fonts.google.com/specimen/Lora

I wanted the titles to be distinct from the body text, but wanted to avoid adding extra fonts in order to keep the page size down. It took me an embarrassingly long time to spot the obvious answer: Use Source Code Pro for titles, as well. In practice, I really like the look of monospace titles. It adds a nice retro flavour and ties code blocks in really as a bonus.

Next: colours. The main colour seemed obvious at first. Blue is my favourite colour forever and always. Because I'm a grownup. But in practice I could never get it to look quite right. I also couldn't find a complementary accent colour I was entirely happy with. Then one day, while out for a run, I had a thought: “What about orange and teal?”. The maligned (but somewhat justified) primary colour palette of almost every modern film. Using it as the colour palette of my website would act as nod to my being a… well… giant film nerd. It’s also a nod to the results of my taking the [True Colours] personality test at an internal training course. I came out as "primarily green, with a strong secondary orange". You’ll have to take my word for it that this is much less naff that it sounds.

[True Colours]: https://en.wikipedia.org/wiki/True_Colors_(personality)

I decided to make Teal the primary colour, mainly because I like it way more than I like orange. The actual shades I pulled from Google’s Material Design [Colour Palette]. For the body text I'm also using Material Design's standard off-black. Titles, block quote sidebars and horizontal lines use teal. Bullets also start teal at the first level and alternate between orange and teal at subsequent levels. Links fade to orange on hover and are underlined in main body text. I didn’t like the way this looked for titles, so titles which are also links instead gain a dinky little hand (there are some examples of this [here]).

[Colour Palette]: https://material.google.com/style/color.html#color-color-palette
[here]: http://harveynick.com/2014/04/26/is-it-that-time-again/

## Layout and Images

I wanted the headline and navigation pinned to the left and the text in a more narrow column down the centre. I've fiddled endlessly with the font size and line height of the body text until I'm mostly happy with them. They're still not quite right, but they'll do. Responsive breakpoints shrink the body text and move the title and navigation to the centre when browser width gets small enough that things start getting tight.

All of the images on the site have rounded corners added with CSS. Header images on the site's main page are short and use the text width, keeping them in flow as though they're paragraphs. They look like this:

![](http://images.harveynick.com/Tag-Hacker.jpg)

Images which are in the flow of a post can grow to be the width of the text, but then start to scale to avoid going beyond it, like so:

![](http://images.harveynick.com/2013-08-11-whilst-not-running-in-australia-DSC00782.JPG)

The headline being left aligned beyond the text gives the page a second width measure. Using a bit of extra HTML an image can use this width instead of the text width. Stylistically, I'm (mostly) going to use this for images with a white background (matching the site background). The extra width and matching background can create the impression that the image is "printed" onto the background of the site, which I think looks nice. Here’s an example with a grey background which completely ignores all of that:

<p class="wide">
<img src="http://images.harveynick.com/2016-06-05-material-design-and-ios_what_is_material_3d_elevation.jpg"></img>
</p>

## Endmatter

I’ve added sharing buttons at the bottom, but they’re made out of plain HTML text. Just links which should share the relevant post on the social network in question, not creepy iFrames which allow those networks to track you.

Lastly: no comments. It’s not that I think comments have to be bad. I’ve never had an issue with anything which faintly resembled abuse in the comments on any blog I’ve had, though I’m aware others have. It’s just that I don’t think they’re worth the effort of setting up on this blog. I don’t get that many comments.

Post-lastly: The Ad which lives at the bottom. I wanted to keep it on the page in order to keep the occasional page view flowing into my AdSense account, which is still sometimes useful for testing (despite that fact that I no longer work on the app). The problem is that AdSense ads just don’t look very nice. So I’ve made it text only, rounded the corners, and picked fonts and colours to match the page. Also I put it at the bottom, because that seems like the way the incentive should work: it’s my job here to get you to read to the bottom of the page.

Like this.

[^1]: Seriously. One of the my first tasks which setting up a new computer is to install it and set it as the default for all terminals and code editors.