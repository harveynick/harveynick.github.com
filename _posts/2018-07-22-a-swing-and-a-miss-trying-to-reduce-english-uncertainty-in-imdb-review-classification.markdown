---
layout: article
title: 'A Swing and a Miss: Trying to Reduce English Uncertainty in IMDB Review Classification'
date: '2018-07-22 18:15:14'
tags:
- hacker
category: "Relearning Machine Learning"
---

When I was following the natural language processing / recurrent neural networks[^1] section of [Andrew Ng’s Deep Learning Specialisation](https://click.linksynergy.com/fs-bin/click?id=X5M728uyIs8&offerid=467035.278&type=3&subid=0), there was a detail which bothered me. Now, having reached the same subject area in [fast.ai’s own deep learning course](http://course.fast.ai/lessons/lesson4.html), the same detail is bothering me again. The structure of the fast.ai course is much more open ended, so I could indulge myself and try to figure it out.

In case the title wasn’t a big enough give away: I was largely unsuccessful. But I’m not convinced I’m wrong, and the specifics of my failure suggest that it might be worth pulling on this thread a little more. Also: I think it’s important to publish negative results as well as positive ones.

Before I get to the detail in question: some background.

## How Neural Networks Understand Natural Language

In short: they don’t. They understand numbers; or lists of numbers; or lists of lists of numbers; and so on.

The simplest way of converting words into a form which can be understood by a neural network is called a “one hot encoding”. Let’s say all of the text you care about uses only the 1000 most common english words, as per [Randall Munroe’s Thing Explainer](https://xkcd.com/thing-explainer/). So then each word is represented by a list of 1000 numbers, exactly one of which is `1`, whilst the rest are `0`. If “a” is the first word, then it will be represented a `1` followed by 999 `0`s.

This has the benefit of being simple. However, it has the disadvantage that it can’t generalise. A system trained against one hot encodings can only ever understand the words it was originally trained against. Furthermore, it has to explicitly learn their relationship to each other. 

A more advanced alternative is to use word vectors. Here each word is represented by a smaller list of numbers of any value, though probably between `0` and `1`. You can think of these as being coordinates in space (though it might be a space with over a hundred dimensions). Words with similar meanings are close together in this space. So the vectors which represent the words *nice* and *pleasant* are likely to be similar. If the word vectors are well tuned, simple maths should also be possible. For example `v['king'] - v['male'] + v['female'] == v['queen']` should hold true.

I’m not going to go too deeply into this, or how the vectors themselves are created. If you want to find out more, check out [word2vec](https://en.wikipedia.org/wiki/Word2vec), which is probably the most well known Implementation.

The crux of this is that language model trained against word vectors rather than one hot encodings has the potential to generalise. The word *nice* might not have appeared in the corpus it was training against, but if its synonym *pleasant* was, then (given the embeddings) it can probably work with that. For a really well trained model, it could potentially even cope with never having seen *queen* if *king*, *male* and *female* were all in the training corpus.

## The Ambiguity of the English Language

Here’s an example from Groucho Marks:

> One morning I shot an elephant in my pyjamas. How he got into my pyjamas I'll never know.

I’m not even going to go there. That’s at least a level of abstraction higher than the problem I have in mind. Namely: the syntactic and semantic ambiguity of individual words. For example: *Still* is a very ambiguous word, having [8 possible interpretations](https://www.google.com/search?safe=off&client=safari&rls=en&ei=io46W-2iLYO3kwWJ5K2wDw&q=define%3Astill&oq=define%3Astill&gs_l=psy-ab.3..0i71k1l8.0.0.0.255811.0.0.0.0.0.0.0.0..0.0....0...1c..64.psy-ab..0.0.0....0.9ssfp72Nmaw "define:still"). These include:

* As an [adjective](https://www.google.com/search?safe=off&client=safari&rls=en&ei=io46W-2iLYO3kwWJ5K2wDw&q=define%3Astill&oq=define%3Astill&gs_l=psy-ab.3..0i71k1l8.0.0.0.255811.0.0.0.0.0.0.0.0..0.0....0...1c..64.psy-ab..0.0.0....0.9ssfp72Nmaw "define:still"), it is a synonym for “unmoving”;
* As a [verb](https://www.google.com/search?safe=off&client=safari&rls=en&ei=io46W-2iLYO3kwWJ5K2wDw&q=define%3Astill&oq=define%3Astill&gs_l=psy-ab.3..0i71k1l8.0.0.0.255811.0.0.0.0.0.0.0.0..0.0....0...1c..64.psy-ab..0.0.0....0.9ssfp72Nmaw "define:still"), it means “cause to be unmoving”, a rough synonym of “quieten”;
* As a [noun](https://www.google.com/search?safe=off&client=safari&rls=en&ei=io46W-2iLYO3kwWJ5K2wDw&q=define%3Astill&oq=define%3Astill&gs_l=psy-ab.3..0i71k1l8.0.0.0.255811.0.0.0.0.0.0.0.0..0.0....0...1c..64.psy-ab..0.0.0....0.9ssfp72Nmaw "define:still") (here we go) it may refer to:
	* A still image, especially one taken from a movie, so a rough synonym of “photograph”;
	* Deep silence;
	* The equipment used to make alcohol, as in “distillery”(!).

It might not even be the most troublesome example. Consider “seed”, which as a well as being a noun has [several possible interpretations as a verb](https://www.google.com/search?safe=off&client=safari&rls=en&ei=qpA6W7_ILc_isAf7vIn4BQ&q=dictionary&oq=dictionary&gs_l=psy-ab.3..0i67k1l2j0j0i20i263k1j0i131k1l2j0l4.2395.4132.0.4369.10.9.0.1.1.0.167.784.0j6.6.0....0...1c.1.64.psy-ab..3.7.801...0i131i67k1.0.7MYTjOu7_VM#dobs=seed "dictionary"). The first means, essentially, “to add seeds”. One of the others? “To *remove* seeds”[^2].

## Put That Together and What Have You Got?

Hopefully you see the problem. For the word vectors to work the way they’re usually constructed, the vector which represents *still* somehow has to encode it’s similarity with the words *unmoving*, *photograph* and *distillery*. *seed*’s vector must encode two meanings which are essentially opposites.

I’m not saying that’s actually impossible, but that it makes it very likely that some important nuance will be lost. It seemed pretty odd to me that Andrew Ng didn’t mention this at all. Jeremy Howard has also not mentioned it thus far in the fast.ai course (disclaimer: I’m not finished with this course yet, so he still might).

I can think of three possible reasons for this:

1. It’s a new idea, or at least not well developed;
2. It’s been tried, and it doesn’t make any difference;
3. It’s a more advanced topic.

I made a conscious decision not to look into either latter possibility. I will later, but first I wanted to dive in and see what I found. Sometimes it’s worth just trying something with minimal background reading. If you don’t know how possible something is thought to be, you’re less likely to be limited by that knowledge. Of course you might just be repeating the mistakes of others, but that too can be a learning experience.

## My Attempt at a Solution

My plan was pretty simple: don’t look up the word vector using just the word, use the [part-of-speech tag](https://en.m.wikipedia.org/wiki/Part-of-speech_tagging) as well. To put it another way: use different vectors for *still* when used as a verb, and *still* when used as an adjective.

The fast.ai lesson 4 jupyter notebook begins by training a language modelling RNN from scratch against the IMDB reviews data-set, building new word vectors along the way. This RNN is then retrained as a classifier which identifies the sentiment of a particular review. This seemed like an ideal test case for my idea, on the surface at least.

The line of code responsible for building the vocabulary for the data-set looks like this:

```python
TEXT = data.Field(lower=True, tokenize='spacey')
```

The `tokenize` parameter is ultimately resolved [here](https://github.com/pytorch/text/blob/master/torchtext/data/utils.py), with code which looks like this:

```python
import spacy
spacy_en = spacy.load('en')
return lambda s: [tok.text for tok in spacy_en.tokenizer(s)]
```

`tokenize` can be either a callable entity, or a string which represents a known tokeniser, as above[^3]. Spacey already performs part of speech tagging as part of the tokenisation process, so I can use the following to get the effect that I want:

```python
import spacy
spacy_tok = spacy.load('en')
tok_pos = lambda s: [tok.text + "-" + tok.pos_.lower() for tok in spacy_tok(s)]
TEXT = data.Field(lower=True, tokenize=tok_pos)
```

Now, when tokenised, the phrase “Still the film still” becomes `['still-verb', 'the-det', 'film-noun', 'still-adv']` instead of `['still', 'the', 'film', 'still']`. Alternatively, for a more fine-grained output, I can use this in the lambda:

```python
[tok.text + "-" + tok.tag_.lower() for tok in spacy_tok(s)]
```

This yields more information about the part of speech. So whereas `pos_` might yield “verb”, `tag_` will provide the type of verb e.g. “transitive verb”. This might might reduce the ambiguity even further, or it might just make it harder for the system to build good vectors.

## The Effect on Building the Model

Both of my modified tokenisation strategies take a lot longer than the default. Rather than taking fifteen to twenty minutes to build the `TEXT` field, they take two to three hours. The resulting change in vocabulary size is significant, though.

<div class="wide">
  <canvas id="vocab"></canvas>
</div>
<script>
  window.hvynck_charts["vocab"] = {
    type: 'bar',
    data: {
      labels: [
        'Original',
        'Simple Tags',
        'Complex Tags',
      ],
      datasets: [{
        label: "Vocabulary Size",
        backgroundColor: [
          window.hvynck_clrs.RED,
		  window.hvynck_clrs.BLUE,
		  window.hvynck_clrs.YELLOW,
        ],
        data: [ 37392, 44599, 46108 ],
      },],
    },
    options: {
      responsive: true,
      legend: { display: false, },
      tooltips: {mode: 'nearest', intersect: false, },
      hover: { mode: 'nearest', intersect: false, },
      title: {
        display: false,
        text: 'Vocabulary Size',
      },
      scales: {
        yAxes: [{
          scaleLabel: { 
            display: true,
            labelString: "Vocabulary Size",
            padding: 0,
          }, 
		  ticks: {min: 0},}],
      },
    }
  };
</script>

<noscript>
<table>
<tr><th>Model</th><th>Vocabulary Size</th></tr>
<tr><td>Original</td><td>37392</td></tr>
<tr><td>Simple Tags</td><td>44599</td></tr>
<tr><td>Complex Tags</td><td>46108</td></tr>
</table>
</noscript>

Likely as a result of this increased vocabulary, the per epoch training time for the language modelling phase increases from around seven and half minutes per epoch to around nine minutes per epoch.

As a first step, I followed identical training schedules for all three options. There are thirty-five epochs in fast.ai’s schedule so the training time increases from 260 minutes to 315 minutes, almost an hour more.

What did I have to show for these additional hours of tagging and training? Here are my final values for the training and validation loss:

<div class="wide">
  <canvas id="loss"></canvas>
</div>
<script>
  window.hvynck_charts["loss"] = {
    type: 'bar',
    data: {
      labels: [
        'Original',
        'Simple Tags',
        'Complex Tags',
      ],
      datasets: [
        {
          label: "Training",
          backgroundColor:
		    window.hvynck_clrs.BLUE,
          data: [ 4.2471, 4.3200, 4.2976 ],
        },
		{
		  label: "Validation",
		  backgroundColor:
			window.hvynck_clrs.RED,
		  data: [ 4.211433, 4.254242, 4.254888 ],
		},
      ],
    },
    options: {
      responsive: true,
      legend: { display: true, },
      tooltips: {mode: 'nearest', intersect: false, },
      hover: { mode: 'nearest', intersect: false, },
      title: {
        display: false,
        text: 'Loss',
      },
      scales: {
        yAxes: [{
          scaleLabel: { 
            display: true,
            labelString: "Loss",
            padding: 0,
          }, 
		  ticks: {min: 4},}],
      },
    }
  };
</script>

<noscript>
<table>
<tr><th>Model</th><th>Training Loss</th><th>Validation Loss</th></tr>
<tr><td>Original</td><td>4.2471</td><td>4.2114</td></tr>
<tr><td>Simple Tags</td><td>4.3200</td><td>4.2542</td></tr>
<tr><td>Complex Tags</td><td>4.2976</td><td>4.2548</td></tr>
</table>
</noscript>

And here is the validation [perplexity](https://en.m.wikipedia.org/wiki/Perplexity):

<div class="wide">
  <canvas id="perplexity"></canvas>
</div>
<script>
  window.hvynck_charts["perplexity"] = {
    type: 'bar',
    data: {
      labels: [
        'Original',
        'Simple Tags',
        'Complex Tags',
      ],
      datasets: [{
        label: "Perplexity",
        backgroundColor: [
          window.hvynck_clrs.RED,
		  window.hvynck_clrs.BLUE,
		  window.hvynck_clrs.YELLOW,
        ],
        data: [ 67.453131, 70.403431, 70.448926 ],
      },],
    },
    options: {
      responsive: true,
      legend: { display: false, },
      tooltips: {mode: 'nearest', intersect: false, },
      hover: { mode: 'nearest', intersect: false, },
      title: {
        display: false,
        text: 'Perplexity',
      },
      scales: {
        yAxes: [{
          scaleLabel: { 
            display: true,
            labelString: "Perplexity",
            padding: 0,
          }, 
		  ticks: {min: 0},}],
      },
    }
  };
</script>

<noscript>
<table>
<tr><th>Model</th><th>Perplexity</th></tr>
<tr><td>Original</td><td>67.4531</td></tr>
<tr><td>Simple Tags</td><td>70.4034</td></tr>
<tr><td>Complex Tags</td><td>70.4489</td></tr>
</table>
</noscript>

There’s nothing too surprising there. The task of predicting the next word *and* its part of speech is harder than predicting just the next word. A larger vocabulary is harder to model. Given the same amount of training time, the system gets a lower score on the more complex task.

## The Effect on the Sentiment Detection

This will be a very short section. It’s pretty easy to sum up: almost none. Which is disappointing, I have to admit. In all cases, training took around 1 minute per epoch. Also in all cases, the accuracy is about `93%`. Across all three cases, the range of the final accuracy is about `0.2%`, which I think is well within the margin of error. I’m not even going to bother charting it. The version with the simple tags scored lowest, the version one the complex tags scored highest. But the differences are so small that I suspect small changes in the distribution between training and validation sets would remove them. Given the random initialisation, there’s even a good chance that just repeating the experiment would give a different ordering.

## Analysis

On the one hand: this didn’t make things any better, on the other: it didn’t make them any worse. The fact that the model which uses the parts of speech can do worse at the language modelling stage but still get the same score for sentiment detection is pretty interesting.

Howard notes in the lecture that once the training schedule in the notebook is complete the network isn’t really close to overfitting. If anything, I think the modified versions are even further away. There’s still lots of room to train all three versions of the model.

I think that’s most the likely the best approach to carry forwards:

1. Train the language modelling system almost to overfitting;
2. Train the sentiment detection almost to overfitting;

Then repeat this this with the versions which incorporate the part of speech tags. Once the three models are fully trained, a better comparison can probably be made.

Thus far I’ve been doing all of the training inside a Jupytor notebooks. That’s great for interactivity, but highly suboptimal for long lived training. If the browser tab crashes or loses its connection to the kernel hours of work can be lost. So if I do take another run at this I’ll probably also use it as a reason to learn how to use [Paperspace’s Gradient](https://www.paperspace.com/gradient) system, which allows long lived jobs to be run remotely[^4].

Discuss this post on [Hacker News](https://news.ycombinator.com/item?id=17588025).

[^1]:	The sub-course in question is actually called “sequence models”.

[^2]:	Apparently this is called a  [“Janus Word”](https://www.merriam-webster.com/words-at-play/words-own-opposites) or contronym.

[^3]:	This sort of things sometimes freaks me out about Python.

[^4]:	It’s very similar to how [Floydhub](https://www.floydhub.com) works, as far as I can tell.