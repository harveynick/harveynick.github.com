---
layout: article
title: 'Kaggle’s Yelp Restaurant Photo Classification Competition, Fast.ai Style:
  Part 2'
date: '2018-06-30 09:35:20'
tags:
- hacker
---

Note: This post has a lot of javascript graphs, but if you’re using a feed reader or have javascript turned off you’ll just get basic tables. Sorry about that.

With that out of the way: I’m going to assume that if you’re reading this you’ve already read [Part 1](https://harveynick.com/2018/06/24/kaggles-yelp-restaurant-photo-classification-competition-fast-ai-style-part-1/). As such, I’m just going to dive right back in where I left off.

# Calculating the Per Business F1 on the Fly

Having now calculated the per business F1 at the end of the training run, I realised it would be useful (or at least interesting) to be able to see how it was changing during training. The per photo F1 makes for a decent heuristic, but isn’t guaranteed to actually correlate with the per business F1, which is what I actually care about.

I hit another snag here with the the fast.ai library. At the end of each epoch, the metrics supplied by the user are calculated using the same batch size as training. The results for each batch are then averaged, and this is what is shown to the user.

That’s a problem for calculating the per business F1, as the entire dataset is needed to build the per business predictions. As a smaller and less obvious problem: it also means that the per photo F1 which is displayed at the end of the epoch will be even more inflated than I thought. This is because rather than finding the best threshold for the entire data set, a more specialised threshold will be found for each batch. It’s overfitting, essentially. The premature optimisation of the machine learning world.

I could solve both problems if I could collate the per photo predications before calculating the F1. If I had access to state which persisted between batches, I could use something like the method below to collate the predictions and target values.

```python
def collate(preds, targs, data):
  multiplier = 1.0
  if preds.shape[0] != len(photo_idx_to_val_biz_idx):
    if data['preds'] is None:
      data['preds'] = preds
      data['targs'] = targs
      # The dataset is incomplete.
      return 0, None, None
    # Append the data to the known data.
    data['preds'] = torch.cat([data['preds'], preds])
    data['targs'] = torch.cat([data['targs'], targs])
    if data['preds'].shape[0] != len(photo_idx_to_val_biz_idx):
      # The dataset is incomplete.
      return 0, None, None
    # The dataset is complete.
    # See below for an explanation of the multiplier.
    multiplier = len(photo_idx_to_val_biz_idx) / preds.shape[0]
    preds = data['preds']
    targs = data['targs']
    data['preds'] = None
    data['targs'] = None
  return multiplier, preds, targs
```

That’s all well and good, but the metric calculations are supplied to the fast.ai library as a pure function, which is then run without additional state or context. Except… this is Python, and calling something a “pure” function is [a sign, *not* a cop](https://imgur.com/gallery/mSHi8). Functions in Python are first class objects, and objects in Python have arbitrarily assignable state. So there is a way around this problem…

Warning: If the Python code I admitted to using elsewhere in these posts bothers you, that below will almost certainly bother you even more. And it should. It’s a horrible hack, and nothing like it should ever get anywhere near a production environment. It should never even get near the critical path of a *non* production environment. But still. I’m not using it for either of those things.

```python
def f1_biz_avg(preds, targs, start=0.24, end=0.50, step=0.01):
  # Collate the predictions and targets, using persistent
  # state attached to this function.
  multiplier, preds, targs = collate(preds, targs, f1_biz_avg.data)

  # A multiplier of 0 means that collation is incomplete.
  if multiplier == 0.0:
    return 0
    
  # Convert the per photo values to per business values.
  biz_preds, biz_targs = photo_to_biz(preds, targs, True)

  # Ignore warnings.
  with warnings.catch_warnings():
    warnings.simplefilter("ignore")

        # Find the threshold which yields the best F1.
    mapping = {th : f1_score(biz_targs, (biz_preds > th), average='samples')
           for th in np.arange(start,end,step)}
    th = max(mapping.keys(), key=mapping.get)

    # Return the best F1, scaled so that the fast.ai library
    # will average it with the 0's to get the correct value. 
    return mapping[th] * multiplier

# Initialize the persistent state.
f1_biz_avg.data = {'preds': None, 'targs': None}
```

This works around two issues:

1. Collating the predications before calculating the F1;
2. Scaling the output of the final batch so that when it’s averaged with the zeros returned for the other batches the correct value results.

I’ll say it again: all of this is a horrible hack. I’m ashamed of it. I worry that if anyone who works for my employer sees this, I might be fired. And yet...

 ![](http://images.harveynick.com/2018-06-29-kaggles-yelp-restaurant-part-2-1-proud_meme.jpeg)

This is how the per photo F1 compares to the business F1 over the course of the training schedule:

<div class="wide">
  <canvas id="f1photovsbiz"></canvas>
</div>
<script>
  window.hvynck_charts["f1photovsbiz"] = {
    type: 'line',
    data: {
      labels: [
        ['1', '1'], ['2'], ['3'], ['4'], ['5'],
		['1', '2'], ['2'], ['3'], ['4'], ['5'], ['6'], ['7'],
		['1', '3'], ['2'], ['3'], ['4'], ['5'],
		['1', '4'], ['2'], ['3'], ['4'], ['5'], ['6'], ['7'],
      ],
      datasets: [
		{
		label: 'Per Photo F1',
		borderColor: window.hvynck_clrs.RED,
		backgroundColor: window.hvynck_clrs.RED,
		fill: false,
		data: [ 
		  0.7119, 0.7261, 0.7307, 0.7324, 0.7336,
		  0.7357, 0.7413, 0.7421, 0.7448, 0.7466, 0.7473, null,
		  0.7485, 0.7493, 0.7495, 0.7491, 0.7497,
		  0.7516, 0.7537, 0.7533, 0.7554, 0.7562, 0.7563, 0.7565,],
	  	},
		{
		label: 'Per Business F1',
		borderColor: window.hvynck_clrs.BLUE,
		backgroundColor: window.hvynck_clrs.BLUE,
		fill: false,
		data: [ 
		  0.7422, 0.7352, 0.7374, 0.7394, 0.7369,
		  0.7422, 0.7500, 0.7543, 0.7610, 0.7723, 0.7647, null,
		  0.7618, 0.7686, 0.7682, 0.7641, 0.7663,
		  0.7776, 0.7760, 0.7766, 0.7856, 0.7807, 0.7874, 0.7845,],
	  	},
	  ],
    },
    options: {
      responsive: true,
      legend: { display: true, },
      tooltips: {mode: 'index', intersect: false, },
      hover: { mode: 'index', intersect: false, },
      title: {
        display: false,
      },
      scales: {
        yAxes: [
          {
            scaleLabel: { 
              display: true,
			  labelString: "F1 Score",
              padding: 0,
            },
          },
        ],
      },
    }
  };
</script>

<noscript>
<table>
<tr><th>Set</th><th>Epoch</th><th>Per Photo F1</th><th>Per Business F1</th></tr>
<tr><td>1</td><td>1</td><td>0.711957</td><td>0.74221</td></tr>
<tr><td></td><td>2</td><td>0.726165</td><td>0.735293</td></tr>
<tr><td></td><td>3</td><td>0.730785</td><td>0.737406</td></tr>
<tr><td></td><td>4</td><td>0.732486</td><td>0.739411</td></tr>
<tr><td></td><td>5</td><td>0.733644</td><td>0.736971</td></tr>
<tr><td>2</td><td>1</td><td>0.73573</td><td>0.742263</td></tr>
<tr><td></td><td>2</td><td>0.741325</td><td>0.750094</td></tr>
<tr><td></td><td>3</td><td>0.742113</td><td>0.754373</td></tr>
<tr><td></td><td>4</td><td>0.744895</td><td>0.761078</td></tr>
<tr><td></td><td>5</td><td>0.746609</td><td>0.77235</td></tr>
<tr><td></td><td>6</td><td>0.74738</td><td>0.76478</td></tr>
<tr><td></td><td>7</td><td></td><td></td></tr>
<tr><td>3</td><td>1</td><td>0.748527</td><td>0.761866</td></tr>
<tr><td></td><td>2</td><td>0.74936</td><td>0.768682</td></tr>
<tr><td></td><td>3</td><td>0.749511</td><td>0.768273</td></tr>
<tr><td></td><td>4</td><td>0.749174</td><td>0.764132</td></tr>
<tr><td></td><td>5</td><td>0.749718</td><td>0.766357</td></tr>
<tr><td>4</td><td>1</td><td>0.751661</td><td>0.777684</td></tr>
<tr><td></td><td>2</td><td>0.753739</td><td>0.776017</td></tr>
<tr><td></td><td>3</td><td>0.753325</td><td>0.776626</td></tr>
<tr><td></td><td>4</td><td>0.755435</td><td>0.785654</td></tr>
<tr><td></td><td>5</td><td>0.756214</td><td>0.780722</td></tr>
<tr><td></td><td>6</td><td>0.756346</td><td>0.787445</td></tr>
<tr><td></td><td>7</td><td>0.756536</td><td>0.784503</td></tr>
</table>
</noscript>

As you can see the per business F1 is consistently higher than the per photo, but less stable. The latter makes sense, given that the model is being trained against the individual photos, not the business. The former was a little surprising to me. I assume the mixed signals start to cancel each other out when you average the predications together.

## Comparing Different Architectures

An F1 of `0.7845` was actually pretty close to my original goal, but not quite there. The obvious next step was to try the same approach with a more advanced model. I also thought it might be interesting to compare the performance of a few different CNN architectures for my own information. So next I ran the exact same schedule, but using the [ResNet-50](https://www.kaggle.com/pytorch/resnet50) and [ResNext-50](https://github.com/facebookresearch/ResNeXt) CNN architectures.

<div class="wide">
  <canvas id="archcomp"></canvas>
</div>
<script>
  window.hvynck_charts["archcomp"] = {
    type: 'line',
    data: {
      labels: [
        ['1', '1'], ['2'], ['3'], ['4'], ['5'],
		['1', '2'], ['2'], ['3'], ['4'], ['5'], ['6'], ['7'],
		['1', '3'], ['2'], ['3'], ['4'], ['5'],
		['1', '4'], ['2'], ['3'], ['4'], ['5'], ['6'], ['7'],
      ],
      datasets: [
		{
		label: 'ResNet-34',
		borderColor: window.hvynck_clrs.RED,
		backgroundColor: window.hvynck_clrs.RED,
		fill: false,
		data: [ 
		  0.7422, 0.7352, 0.7374, 0.7394, 0.7369,
		  0.7422, 0.7500, 0.7543, 0.7610, 0.7723, 0.7647, null,
		  0.7618, 0.7686, 0.7682, 0.7641, 0.7663,
		  0.7776, 0.7760, 0.7766, 0.7856, 0.7807, 0.7874, 0.7845,],
	  	},
		{
		label: 'ResNet-50',
		borderColor: window.hvynck_clrs.BLUE,
		backgroundColor: window.hvynck_clrs.BLUE,
		fill: false,
		data: [ 
		  0.7870, 0.7775, 0.7720, 0.7739, 0.7692,
		  0.7632, 0.7752, 0.7811, 0.7824, 0.7863, 0.7911, 0.7913,
		  0.7906, 0.8002, 0.7865, 0.7893, 0.7992,
		  0.8054, 0.8020, 0.8061, 0.8053, 0.8021, 0.8085, 0.8082,],
	  	},
		{
		label: 'ResNext-50',
		borderColor: window.hvynck_clrs.YELLOW,
		backgroundColor: window.hvynck_clrs.YELLOW,
		fill: false,
		data: [ 
		  0.7919, 0.7828, 0.7645, 0.7686, 0.7676,
		  0.7793, 0.7888, 0.7882, 0.7942, 0.7996, 0.7998, 0.7976,
		  0.7936, 0.8000, 0.8020, 0.7944, 0.7976,
		  0.8021, 0.7995, 0.8051, 0.8069, 0.8045, 0.8068, 0.8078,],
	  	},
	  ],
    },
    options: {
      responsive: true,
      legend: { display: true, },
      tooltips: {mode: 'index', intersect: false, },
      hover: { mode: 'index', intersect: false, },
      title: {
        display: false,
      },
      scales: {
        yAxes: [
          {
            scaleLabel: { 
              display: true,
			  labelString: "F1 Score",
              padding: 0,
            },
          },
        ],
      },
    }
  };
</script>

<noscript>
<table>
<tr><th>Set</th><th>Epoch</th><th>resnet34</th><th>resnet50</th><th>resnext50</th></tr>
<tr><td>1</td><td>1</td><td>0.711957</td><td>0.727451</td><td>0.72667</td></tr>
<tr><td></td><td>2</td><td>0.726165</td><td>0.73852</td><td>0.737242</td></tr>
<tr><td></td><td>3</td><td>0.730785</td><td>0.742298</td><td>0.740598</td></tr>
<tr><td></td><td>4</td><td>0.732486</td><td>0.744425</td><td>0.742447</td></tr>
<tr><td></td><td>5</td><td>0.733644</td><td>0.745335</td><td>0.743586</td></tr>
<tr><td>2</td><td>1</td><td>0.73573</td><td>0.745172</td><td>0.747723</td></tr>
<tr><td></td><td>2</td><td>0.741325</td><td>0.750352</td><td>0.753836</td></tr>
<tr><td></td><td>3</td><td>0.742113</td><td>0.751288</td><td>0.754403</td></tr>
<tr><td></td><td>4</td><td>0.744895</td><td>0.754363</td><td>0.75765</td></tr>
<tr><td></td><td>5</td><td>0.746609</td><td>0.75604</td><td>0.759276</td></tr>
<tr><td></td><td>6</td><td>0.74738</td><td>0.756608</td><td>0.759684</td></tr>
<tr><td></td><td>7</td><td></td><td>0.75674</td><td>0.760055</td></tr>
<tr><td>3</td><td>1</td><td>0.748527</td><td>0.758205</td><td>0.761691</td></tr>
<tr><td></td><td>2</td><td>0.74936</td><td>0.758833</td><td>0.762266</td></tr>
<tr><td></td><td>3</td><td>0.749511</td><td>0.758572</td><td>0.762637</td></tr>
<tr><td></td><td>4</td><td>0.749174</td><td>0.759194</td><td>0.762198</td></tr>
<tr><td></td><td>5</td><td>0.749718</td><td>0.759701</td><td>0.762108</td></tr>
<tr><td>4</td><td>1</td><td>0.751661</td><td>0.761914</td><td>0.761366</td></tr>
<tr><td></td><td>2</td><td>0.753739</td><td>0.763467</td><td>0.762696</td></tr>
<tr><td></td><td>3</td><td>0.753325</td><td>0.762945</td><td>0.762683</td></tr>
<tr><td></td><td>4</td><td>0.755435</td><td>0.764565</td><td>0.76418</td></tr>
<tr><td></td><td>5</td><td>0.756214</td><td>0.764523</td><td>0.764647</td></tr>
<tr><td></td><td>6</td><td>0.756346</td><td>0.765443</td><td>0.764441</td></tr>
<tr><td></td><td>7</td><td>0.756536</td><td>0.765464</td><td>0.765044</td></tr>
</table>
</noscript>
I was pretty sure that both 50 layer architectures would do consistently better than ResNet-34, but I also thought that ResNext-50 would do consistently better than ResNet-50. So I was half right.

One advantage ResNext-50 did have is that it trained more quickly. Stupidly, I didn’t record the training time for each architecture. I trained ResNet-34 over the course of a day. I’d say that ResNet-50 look about half as long again to train as ResNet-34[^1]. ResNext-50 seemed like it took about halfway between the two. But that could be my imagination. Next time I should actually record the timings…

Be that as it may, my initial goal was to achieve an F1 score of at least `0.8` against the validation set. `0.8082` is (just barely) higher than that, so: mission accomplished, I guess.

Right?

## Trying Class Specific Thresholds

At this point I started to realise a few things which would have been obvious at the top if I had more experience. Firstly, after I started writing this post I realised it might be interesting to graph the proportion of businesses which belong to each class. For your convenience (and in the interest of making the following charts readable on mobile), here are the class names again:

0. Good for lunch;
1. Good for dinner;
2. Takes reservations;
3. Outdoor seating;
4. Restaurant is expensive;
5. Has alcohol;
6. Has table service;
7. Ambience is classy;
8. Good for kids.

And here is a graph of their proportions:

<div class="wide">
  <canvas id="proportion"></canvas>
</div>
<script>
  window.hvynck_charts["proportion"] = {
    type: 'bar',
    data: {
      labels: [ '0', '1', '2', '3', '4', '5', '6', '7', '8', 'Mean' ],
      datasets: [{
		borderColor: window.hvynck_clrs.BLUE,
		backgroundColor: window.hvynck_clrs.BLUE,
        data: [ 0.3300, 0.5125, 0.5275, 0.5125, 0.2625, 0.6375, 0.6850, 0.2825, 0.6075, 0.4842 ],
      },],
    },
    options: {
      responsive: true,
      legend: { display: false, },
      tooltips: {mode: 'nearest', intersect: false, },
      hover: { mode: 'nearest', intersect: false, },
      title: {
        display: false,
        text: 'Proportion of Businesses with each Class',
      },
      scales: {
        yAxes: [
          {
            scaleLabel: { 
              display: true,
              labelString: "Proportion",
              padding: 0,
            },
            ticks: {min: 0, max: 1},
          },
        ],
      },
    }
  };
</script>

<noscript>
<table>
<tr><th>Class</th><th>Proportion</th></tr>
<tr><td>good_for_lunch</td><td>0.3300</td></tr>
<tr><td>good_for_dinner</td><td>0.5125</td></tr>
<tr><td>takes_reservations</td><td>0.5275</td></tr>
<tr><td>outdoor_seating</td><td>0.5125</td></tr>
<tr><td>restaurant_is_expensive</td><td>0.2625</td></tr>
<tr><td>has_alcohol</td><td>0.6375</td></tr>
<tr><td>has_table_service</td><td>0.6850</td></tr>
<tr><td>ambience_is_classy</td><td>0.2825</td></tr>
<tr><td>good_for_kids</td><td>0.6075</td></tr>
<tr><td>average</td><td>0.4842</td></tr>
</table>
</noscript>

Following on from this, I started to wonder whether my system was doing better on some classes rather than others. Which is when the obvious thought arrived: I was using the same threshold for each class, but I had no reason to assume that the sensitivity was the same. I could probably get better results by using different thresholds for each class.

I ran the following code against the inference output for the validation set to find the best individual threshold for for each class:

```python
def per_class_threshholds(preds, targs, start=0.04, end=0.50, step=0.001):

  # Initialize the per class threshholds to 0.
  thresholds = np.zeros((preds.shape[1]))

  # Ignore warnings.
  with warnings.catch_warnings():
    warnings.simplefilter("ignore")
  
    # Iterate 10 times, trying to improve the thresholds each
    # time.
    # Note: This is overkill, but runs quickly enough not to matter.
    # Some CPU time could be saved by stopping once the F1 is no 
    # longer improving.
    for _ in range(10):
      # Try to improve the threshold for each class in turn.
      for i in range(0, thresholds[0]):
        best_th = 0.0
        best_score = 0.0
        for th in np.arange(start, end, step):
          thresholds[i] = th
          score = f1_score(targs, (preds > thresholds), average='samples')
          if score > best_score:
            best_th = th
            best_score = score
        thresholds[i] = best_th

  return thresholds
```

Running this for each of three architectures individually gave me the per class F1 scores. You can see them in the graph below, which I’ve foreshortened to emphasise the differences in performance:

<div class="wide">
  <canvas id="perclassf1"></canvas>
</div>
<script>
  window.hvynck_charts["perclassf1"] = {
    type: 'bar',
    data: {
      labels: [ '0', '1', '2', '3', '4', '5', '6', '7', '8', 'Mean'],
      datasets: [
        {
	  	  label: 'ResNet-34',
		  borderColor: window.hvynck_clrs.RED,
		  backgroundColor: window.hvynck_clrs.RED,
          data: [ 0.6824, 0.8326, 0.8728, 0.6944, 0.7510, 0.8905,
                  0.9252, 0.7672, 0.8716, 0.8097 ],
        },
		{
	  	  label: 'ResNet-50',
		  borderColor: window.hvynck_clrs.BLUE,
		  backgroundColor: window.hvynck_clrs.BLUE,
		  data: [ 0.6643, 0.8387, 0.8874, 0.7449, 0.7401, 0.9136,
	              0.9329, 0.7679, 0.8835, 0.8193 ],
		},
		{
	  	  label: 'ResNext-50',
		  borderColor: window.hvynck_clrs.YELLOW,
		  backgroundColor: window.hvynck_clrs.YELLOW,
		  data: [ 0.6053, 0.8372, 0.8805, 0.7329, 0.7570, 0.8869, 
                  0.9310, 0.7857, 0.8793, 0.8106 ],
		},
      ],
    },
    options: {
      responsive: true,
      legend: { display: true, },
	  tooltips: {mode: 'index', intersect: false, },
	  hover: { mode: 'index', intersect: false, },
      title: {
        display: false,
        text: 'Proportion of Businesses with each Class',
      },
      scales: {
        yAxes: [
          {
            scaleLabel: { 
              display: true,
			  labelString: "F1 Score",
              padding: 0,
            },
            ticks: {min: 0.5, max: 1},
          },
        ],
      },
    }
  };
</script>

<noscript>
<table>
<tr><th>Class</th><th>resnet34 F1</th><th>resnet50 F1</th><th>resnext50 F1</th><th>Ensemble F1</th></tr>
<tr><td>good_for_lunch</td><td>0.6824</td><td>0.6643</td><td>0.6053</td><td>0.6824</td></tr>
<tr><td>good_for_dinner</td><td>0.8326</td><td>0.8387</td><td>0.8372</td><td>0.8387</td></tr>
<tr><td>takes_reservations</td><td>0.8728</td><td>0.8874</td><td>0.8805</td><td>0.8874</td></tr>
<tr><td>outdoor_seating</td><td>0.6944</td><td>0.7449</td><td>0.7329</td><td>0.7449</td></tr>
<tr><td>restaurant_is_expensive</td><td>0.7510</td><td>0.7401</td><td>0.7570</td><td>0.7570</td></tr>
<tr><td>has_alcohol</td><td>0.8905</td><td>0.9136</td><td>0.8869</td><td>0.9136</td></tr>
<tr><td>has_table_service</td><td>0.9252</td><td>0.9329</td><td>0.9310</td><td>0.9329</td></tr>
<tr><td>ambience_is_classy</td><td>0.7672</td><td>0.7679</td><td>0.7857</td><td>0.7857</td></tr>
<tr><td>good_for_kids</td><td>0.8716</td><td>0.8835</td><td>0.8793</td><td>0.8835</td></tr>
<tr><td>average</td><td>0.8097</td><td>0.8193</td><td>0.8106</td><td>0.8251</td></tr>
</table>
</noscript>

There’s actually more variation than I was expecting. Firstly between the per class scores. There’s some correlation with the per class proportions above, but not for every class. Accounting for that effect, “Good for lunch” and “takes reservations” appear to be the hardest classes to detect.

Secondly the best architecture is not consistent across the classes. ResNet-34 is actually a bit of a dark horse when it comes to detecting establishments which open for lunch. Who knew?

Speaking of ideas which occur to you after the fact: I’m willing to bet that the time stamp of the photo is probably a pretty solid signal for the “good for lunch” class.

At this point I didn’t trust the overall F1 scores these thresholds gave me against the validation set. It was time run against the test set, submit to Kaggle, and find out what my real score was. I did this for each of the architectures, and also built an ensemble output by using the predictions of the architecture which got the best score for each class.

Having run inference on the test data, I used the following code to build per business predications[^3] and generate the formatted output.

```python
predications = # The per photo predictions.
test_photo_to_biz = f'{PATH}/test_photo_to_biz.csv'
test_photo_to_biz_data = pd.read_csv(test_photo_to_biz)

# Gather the individual business IDs, and the image counts
# for each business.
biz_counts = {}
for biz_id in test_photo_to_biz_data.business_id:
  biz_counts.setdefault(biz_id, 0)
  biz_counts[biz_id] += 1
biz_ids = list(biz_counts.keys())
biz_idxs = {biz_ids[i] : i for i in range(len(biz_ids))}

# Extract the photo IDs in order from the test image file names.
images_in_order = [v[9:-4] for v in learn.data.test_ds.fnames]
photo_idxs = {int(images_in_order[i]) : i for i in range(len(images_in_order))}

# Convert the per photo predictions to per business predictions.
biz_preds = np.zeros((len(biz_ids), preds2.shape[1]))
for i in range(test_photo_to_biz_data.shape[0]):
  photo_id = test_photo_to_biz_data.photo_id[i]
  photo_idx = photo_idxs[photo_id]
  photo_preds = predications[photo_idx, :]
  
  biz_id = test_photo_to_biz_data.business_id[i]
  biz_idx = biz_idxs[biz_id]
  biz_count = biz_counts[biz_id]
  
  biz_preds[biz_idx, :] += photo_preds * (1.0 / biz_count)

# Convert the predications into booleans.
biz_cls = preds > threshholds

# Convert the booleans into lists of matched classes.
classes = []
for i in range(biz_cls.shape[0]):
  biz_cls_biz = biz_cls[i, :]
  biz_classes = " ".join([str(i) for i in range(preds_cls.shape[1]) if biz_cls_biz[i]])
  classes.append(biz_classes)

# Build a pandas data frame with the business IDs and
# matched classes.
data = np.array(list(zip(biz_ids, classes)), order = 'F')
output = pd.DataFrame(data=data, columns=['business_id', 'labels'])
# Write the data frame out to a CSV files.
csv_fn=f'{PATH}tmp/sub_{f_model.__name__}.csv'
output.to_csv(csv_fn, index=False)
# Display a link to the CSV file.
FileLink(csv_fn)
```

The code used to build the ensemble is left as an exercise for the reader. Obviously this is for educational purposes. Not just because I don’t want you to see *my* code and possibly judge me more harshly than you already do for the other code in this post. Ahem.

So, without further ado, here are the final scores against the public and private leaderboards for the competition:

<div class="wide">
  <canvas id="leaderboard"></canvas>
</div>
<script>
  window.hvynck_charts["leaderboard"] = {
    type: 'bar',
    data: {
      labels: [
        'Public Score',
		'Private Score',
      ],
      datasets: [
        {
	  	  label: 'ResNet-34',
		  borderColor: window.hvynck_clrs.RED,
		  backgroundColor: window.hvynck_clrs.RED,
          data: [ 0.7788, 0.78823, ],
        },
		{
	  	  label: 'ResNet-50',
		  borderColor: window.hvynck_clrs.BLUE,
		  backgroundColor: window.hvynck_clrs.BLUE,
		  data: [ 0.8009, 0.8062, ],
		},
		{
	  	  label: 'ResNext-50',
		  borderColor: window.hvynck_clrs.YELLOW,
		  backgroundColor: window.hvynck_clrs.YELLOW,
		  data: [ 0.7872, 0.7830, ],
		},
		{
	  	  label: 'Ensemble',
		  borderColor: window.hvynck_clrs.GREEN,
		  backgroundColor: window.hvynck_clrs.GREEN,
		  data: [ 0.7896, 0.8001, ],
		},
      ],
    },
    options: {
      responsive: true,
      legend: { display: true, },
	  tooltips: {mode: 'index', intersect: false, },
	  hover: { mode: 'index', intersect: false, },
      title: {
        display: false,
        text: 'Final F1 Scores',
      },
	  scales: {
		yAxes: [
		  {
			scaleLabel: { 
			  display: true,
			  labelString: "F1 Score",
			  padding: 0,
			},
			ticks: {min: 0.77, max: 0.82},
		  },
		],
	  },
    }
  };
</script>

<noscript>
<table>
<tr><th>Model</th><th>Public Score</th><th>Private Score</th></tr>
<tr><td>ResNet-34</td><td>0.7788</td><td>0.78823</td></tr>
<tr><td>ResNet-50</td><td>0.8009</td><td>0.8062</td></tr>
<tr><td>ResNext-50</td><td>0.7872</td><td>0.7830</td></tr>
<tr><td>Ensemble</td><td>0.7896</td><td>0.8001</td></tr>
</table>
</noscript>

As you can see, ResNet-50 wins bother leaderboards pretty handily. That’s not a huge surprise, but I really wasn’t expecting ResNet-34 to beat ResNext-50 on the private leaderboard. The ensemble takes a respectable second place on both leaderboards. I would tend to blame overfitting for it not coming first. Overfitting is [Blofeld](https://en.wikipedia.org/wiki/Ernst_Stavro_Blofeld). Absent another obvious villain, it’s usually the culprit.

Regardless, I’m definitely over my target F1 score of `0.8`. Enough over it to get me inside the top 100 on the private leaderboard. Which would put me on the bronze podium. You know… if this competition hadn’t ended two years ago…

## Ideas for Further Improvement

At this stage I have essentially four ideas to try and improve on these results.

The first is simple: try exactly the same approach with a more complex CNN architecture, such as [ResNet-101](https://www.kaggle.com/pytorch/resnet101). The reason I haven’t tried this one already is also simple: time. I already had to train ResNet-50 and ResNext-50 across multiple days. At a rough guess I’d expect ResNet-101 to take twice as long. If I was actually entering a competition here I would probably try it, but since I’m not it doesn’t seem worth the effort. There’s also no guarantee it would actually improve the results. It might just overfit.

Idea two is to tweak the loss function in order to minimise (if not eliminate) the mixed signals it currently sends out. My first thought was to use the standard multi-class loss functions, but de-emphasise or remove the term which punishes false negatives. That would probably lead to a model which just returns false for every class, though. Another thought I had was to add an additional class “none of the above” and then use a single class loss function with no punishment of false negatives. The model would then have to select a single class for each image, or explicitly select that none apply. Of course this would only work if there is at least one image which provides a good representation of each class for each business. As for why I haven’t tried this yet: I’m not experienced enough with PyTorch (which the fast.ai library is based on) and I don’t know how. Yet.

My third idea is to fiddle with the data loader. Each training example would become a business, rather than a photo. When loading the data, the data loader would randomly select (say) 4 of the images for that restaurant and return a composite of them. So it might return the following image (or any other permutation) for business `485`, which I used as an example in [Part 1](https://harveynick.com/2018/06/24/kaggles-yelp-restaurant-photo-classification-competition-fast-ai-style-part-1/):

![](http://images.harveynick.com/2018-06-29-kaggles-yelp-restaurant-part-2-2-composite.jpg)

Idea four isn’t actually my idea at all, but one which came from Hacker News user [kaveh\_h](https://news.ycombinator.com/user?id=kaveh_h) (aka Kaveh Hadjar) in [this comment](https://news.ycombinator.com/item?id=17390896). It amounts to this: use a recurrent neural network (such as an [LSTM](https://en.wikipedia.org/wiki/Recurrent_neural_network#LSTM)) in place of the fully connected classification layers of the model. You would then batch together all of the images for a restaurant, run them all through the network sequentially, and then train / infer based on the final output. It would look something like this (art style shamelessly stolen from [Stratechery](https://stratechery.com)):

![wide](http://images.harveynick.com/2018-06-29-kaggles-yelp-restaurant-part-2-3-extension.jpeg)

RNNs are ideal for handling sequences of data, so there is some possibility that the order the images were supplied in could make a difference. I also have absolutely no idea how I’d go about putting something like that together, either using the fast.ai library or without it.

In summery: I have a lot to learn. Which is quite exciting, to be honest.

[^1]: Probably about `50/34` times as long, in fact.

[^3]: The photo to business prediction code I wrote for the validation set no longer works here. Thankfully something much similar suffices.