---
layout: article
title: 'Kaggle’s Yelp Restaurant Photo Classification Competition, Fast.ai Style:
  Part 1'
date: '2018-06-24 18:07:13'
tags:
- hacker
category: "Relearning Machine Learning"
---

Lectures 3 and 4 of fast.ai’s [Practical Deep Learning for Coders](http://course.fast.ai) MOOC focuses in part on multi-label image classification. Teacher [Jeremy Howard](https://en.wikipedia.org/wiki/Jeremy_Howard_(entrepreneur)) uses the [Understanding the Amazon from Space](https://www.kaggle.com/c/planet-understanding-the-amazon-from-space) Kaggle competition for teaching purposes[^1], and sets homework to try other similar image classification competitions.

The forums point to a template version of the [Jupyter](http://jupyter.org) notebook used in the lecture, which suggests trying the [Yelp Restaurant Photo Classification](https://www.kaggle.com/c/yelp-restaurant-photo-classification) competition. On the surface this actually turned out to be a pretty suboptimal match for the techniques used in the lecture and the default setup of the [fast.ai](https://github.com/fastai/fastai) library. But it did give me an opportunity to dig a little deeper than I might have otherwise.

Howard’s guidance is that students should aim to get an evaluation score which would put them in the top 50% of the leaderboard for the completion. Taking a look at the [leaderboard](https://www.kaggle.com/c/yelp-restaurant-photo-classification/leaderboard) I decided to aim slightly higher: I wanted to get an [F1 score](https://en.wikipedia.org/wiki/F1_score) of at least `0.8`. Ideally this score would be against the test set, but if I managed it against the validation set I’d be happy enough with that.

## Specifics of the Competition

This competition has a degree of separation between the input and the expected output. To explain what I mean by that, let’s compare the training data from the Yelp completion to that from the Amazon competition. In both cases the data is supplied as jpeg images and [CSV files](https://en.wikipedia.org/wiki/Comma-separated_values). For the Amazon competition there is a single CSV file, mapping images to labels. It looks like this:

```
image_name,tags
train_0,haze primary
train_1,agriculture clear primary water
train_2,clear primary
train_3,clear primary
train_4,agriculture clear habitation primary road
train_5,haze primary water
```

Nice and simple. The name of the image on the first column; the labels for the image in the second. Mapping images of satellite imagery to appropriate labels is, after all, the point of this competition. For the yelp competition there are two CSV files. The first maps *businesses* (not images) to labels:

```
business_id,labels
1000,1 2 3 4 5 6 7
1001,0 1 6 8
100,1 2 4 5 6 7
...
485,1 2 3 4 5 6 7
...
```

Again this represents the point of the completion. We’re trying to learn the right labels for a particular restaurant. The images are a data tool we use in order to do so. So, there is a *second* CSV file which maps images to businesses:

```
photo_id,business_id
204149,3034
52779,2805
278973,485
195284,485
19992,485
80748,485
...
```

This is the degree of separation: no direct mapping between the input data (the images) and the desired output (the labels).

This presents two main problems. The first is small: the data needs to be merged into a format which can be used to train a neural network. Solving this leads to the second, much bigger issue: many of the resulting label to image mappings are inappropriate. But there isn’t enough information in the data set to do anything other than map every label for a business to every image for that business.

Consider that there are 9 labels:

0. Good for lunch;
1. Good for dinner;
2. Takes reservations;
3. Outdoor seating;
4. Restaurant is expensive;
5. Has alcohol;
6. Has table service;
7. Ambience is classy;
8. Good for kids.

Now consider business `485` from the data above. It has every label apart form 0 (good for lunch) and 8 (good for kids). Associated with it are these 4 images:

![](http://images.harveynick.com/2018-06-24-kaggles-yelp-restaurant-part-1-1-278973.jpg)

![](http://images.harveynick.com/2018-06-24-kaggles-yelp-restaurant-part-1-2-195284.jpg)

![](http://images.harveynick.com/2018-06-24-kaggles-yelp-restaurant-part-1-3-19992.jpg)

![](http://images.harveynick.com/2018-06-24-kaggles-yelp-restaurant-part-1-4-80748.jpg)

Do each of those images demonstrate each of those labels? I can certainly see that the the presence of wine glasses in the last suggests that alcoholic drinks are available. But there’s nothing in any of the other three pictures which suggests booze is on the menu to my eyes. Likewise I’m not sure the third image suggests any of the labels, yet in training it will be expected to match all of them.

That’s not all. From the description of the data:

> Since Yelp is a community driven website, there are duplicated images in the dataset. They are mainly due to:
> 1. users accidentally upload the same photo to the same business more than once (e.g., [this](https://www.yelp.com/biz_photos/ria-mar-south-river?select=lq_9e9LSxt6PXMYGcO-tFw) and [this](https://www.yelp.com/biz_photos/ria-mar-south-river?select=Z1qaoescegy0ImS3rNvvRA))
> 2. chain businesses which upload the same photo to different branches
> Yelp is including these as part of the competition, since these are challenges Yelp researchers face every day. 

So the same image might be in the training set multiple times, with entirely different labels each time. That’s a lot of mixed signals.

The upshot of this is that the problem is harder. This is borne out by the leaderboard results for the two competitions. The winning score for the Amazon competition is `0.93317` and 100th place has `0.92895`. The winning score for the Yelp competition, however, is `0.83177`, with 100th place getting `0.80087`. Now, I want to stress that this is an apples to oranges comparison. The Yelp competition is graded using the F1 score, whereas the Amazon competition uses the F2 score, which punishes false negatives more harshly. Nevertheless, that’s a big difference and a larger drop off between 1st and 100th place.

Harder doesn’t mean impossible, though. I was curious as to whether the fast.ai techniques would work anyway. Beyond that I wondered if there was anything I could tweak to make them work better.

## Processing the Input and Picking the Validation Set

I originally screwed this up and wasted a good few hours of training. The crux of the matter is this: your validation set should be based on the individual restaurants, not the individual images. I know that the first time around, but I didn’t fully understand the way the fast.ai library would handle it. The following is how I built my second, *correct* validation set.

Side note: I did (and continue to) do all my work for the fast.ai course using the fast.ai template at Paperspace, which I can highly recommend. If you want to try it our you can use my referral code to get $5 credit [here](https://www.paperspace.com/&R=AAGWLUH).

First things first, I set the paths for the input CSV files and loaded them into [pandas](https://pandas.pydata.org) data frames:

```python
PATH = 'data/yelp/'
photo_to_biz = f'{PATH}/train_photo_to_biz_ids.csv'
biz_to_labels = f'{PATH}/train.csv'
photo_to_biz_data = pd.read_csv(photo_to_biz)
biz_to_labels_data = pd.read_csv(biz_to_labels)
```

Next I selected the businesses which will be used for validation using fast.ai’s `get_cv_idxs` method. This provides a random but deterministic[^2] list of indices given a dataset size. I added a new column to the `biz_to_labels_data` data frame and set it to true for every business in the validation set.

```python
val_biz_idxs = get_cv_idxs(biz_to_labels_data.shape[0])
val_biz_idxs_set = set(val_biz_idxs)

for index in range(biz_to_labels_data.shape[0]):
	biz_to_labels_data.loc[index, 'validation_set'] = index in val_biz_idxs_set
```

You specify the validation set to the fast.ai library by giving it a list of the indices in the data set which are to be used for validation. But these indices must be based on the on-disk order of the input files, *not* the order they appear in the input CSV. Remember above when I said that I originally messed up the validation set? This point about how the fast.ai library interprets the validation set indices is where I did it. I didn’t look deeply enough at my original validation set, and that cost me a lot of time.

I joined the two data frames on the `business_id` field. Then sorted the resulting data frame by `photo_id`.  As the `photo_id` field corresponds to the filename of each image, sorting on it means the two orders are now the same. This done, the indices of the validation data can be found by including the row number of each item which has the `validation_set` column I created above set to `True`.

```python
joined = pd.merge(photo_to_biz_data, biz_to_labels_data, on='business_id')
joined.sort_values(by='photo_id', inplace=True)
val_idxs = [i for i in range(joined.shape[0])
            if joined.iloc[i, -1]]
```

Finally what remains is to output just the `photo_id ` and `labels` columns to a new CSV which can be read in by the fast.ai library:

```python
photos_to_labels = f'{PATH}/train_photos_to_labels.csv'
joined.to_csv(photos_to_labels, columns=['photo_id', 'labels'],
			  index=False)
```

A key thing I learned here is that I need more experience with pandas. I’m pretty sure there are much more elegant and idiomatic ways of achieving the above. In the lecture, Howard recommends [Python for Data Analysis](https://amzn.to/2Jdsv8T) which is written by the main author of pandas. That’s going on my todo list. 

## First Runs Through ResNet-34

I’m not going to go too deep into the nuts and bolts of actually training the neural network, nor talk about finding the learning rates. You can find pretty comprehensive notes and code samples for this in the fast.ai course forum [here](http://forums.fast.ai/t/wiki-lesson-3/9401).

There are a few things which [Andrew Ng’s Coursera Deep Learning Specialisation](https://harveynick.com/2018/05/07/some-notes-on-courseras-andrew-ng-deep-learning-speciality/) treats as advanced topics, but fast.ai bakes in from the outset. One of these is [transfer learning](https://en.wikipedia.org/wiki/Transfer_learning). The starting point as taught by fast.ai is to use the [ResNet-34](https://www.kaggle.com/pytorch/resnet34) architecture with weights pre-trained against the [ImageNet](http://www.image-net.org) dataset. The trained weights are kept for the convolutional layers, but new fully connected classification layers are added to the end. Following the fast.ai recipe, I trained the new layers for 5 epochs, keeping the weights of the convolutional layers static. Then I unfroze the weights of the convolutional layers and continued training for a total of 7 epochs[^3].

Something included in fast.ai from the start but not present in Andrew Ng’s course at all is one of Howard’s tricks for avoiding overfitting. This comes now. I increased the size of the input images from 244px to 299px then repeated the the above procedure. This makes the full regime:

1. 5 epochs with an image size of 224px and the convolutional layers frozen;
2. 7 epochs with an image size of 224px and the convolutional layers unfrozen;  
3. 5 epochs with an image size of 299px and the convolutional layers frozen;
4. 7 epochs with an image size of 299px and the convolutional layers unfrozen; 

Why 244px and 299px? It’s mentioned in the lectures that these are the standard sizes of images in the ImageNet dataset, which the ResNet was trained against. When I originally started playing with the data I tried a three stage progression from 64px to 128px to 256px, but found I was getting much better results more quickly by going directly to 244px and 299px. This may or may not be the case for other datasets. Figuring it out is definitely an art. I think Rick put it best:

![](http://images.harveynick.com/2018-06-24-kaggles-yelp-restaurant-part-1-5-sometimes_science.jpg)

The fast.ai library allows you to supply additional metrics when you train the network. These are entirely for the user’s feedback, and have no affect on the training itself. In order to get a better handle on how the training was actually going, I put together a function which returns the best case F1 value by picking the most effective decision boundary:

```python
def f1(preds, targs, start=0.17, end=0.50, step=0.01):

	# Ignore warnings.
	with warnings.catch_warnings():
		warnings.simplefilter("ignore")

		# Find the threshold which yields the best F1.
		# Note: np.arange(...) is essentially range(...) for floats.
		mapping = {th : f1_score(targs, (preds > th), average='samples')
				   for th in np.arange(start,end,step)}
		th = max(mapping.keys(), key=mapping.get)
		
		# Return the F1 generated by this threshold.
		return mapping[th]
```

Running ResNet-34 with the above schedule gave me the following values for the trading and validation losses, plus my highly optimistic per photo F1 metric.

<div class="wide">
  <canvas id="resnet34loss"></canvas>
</div>
<script>
  window.hvynck_charts["resnet34loss"] = {
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
        label: 'Training Loss',
        borderColor: window.hvynck_clrs.RED,
		backgroundColor: window.hvynck_clrs.RED,
		fill: false,
        data: [
			0.6189, 0.5754, 0.5513, 0.5483, 0.5383,
			0.5350, 0.5161, 0.5163, 0.5089, 0.5006, 0.4904, null,
			0.4994, 0.4895, 0.4861, 0.4896, 0.4854,
			0.4831, 0.4777, 0.4849, 0.4744, 0.4750, 0.4693, 0.4756,
		],
      	},
		{
		label: 'Validation Loss',
		borderColor: window.hvynck_clrs.BLUE,
		backgroundColor: window.hvynck_clrs.BLUE,
		fill: false,
		data: [ 
			0.5872, 0.5551, 0.5452, 0.5409, 0.5368,
			0.5356, 0.5239, 0.5222, 0.5165, 0.5146, 0.5115, null,
			0.5094, 0.5093, 0.5088, 0.5079, 0.5070,
			0.5047, 0.5006, 0.5010, 0.4979, 0.4958, 0.4958, 0.4956,
 		],
	  	},
		{
		label: 'Per Photo F1',
		borderColor: window.hvynck_clrs.YELLOW,
		backgroundColor: window.hvynck_clrs.YELLOW,
		fill: false,
		data: [ 
		  0.7119, 0.7261, 0.7307, 0.7324, 0.7336,
		  0.7357, 0.7413, 0.7421, 0.7448, 0.7466, 0.7473, null,
		  0.7485, 0.7493, 0.7495, 0.7491, 0.7497,
		  0.7516, 0.7537, 0.7533, 0.7554, 0.7562, 0.7563, 0.7565,],
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
              labelString: "Loss / F1",
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
<th><td>Set</td><td>Epoch</td><td>Training Loss</td><td>Validation Loss</td><td>F1</td></th>
<tr><td>1</td><td>1</td><td>0.618955</td><td>0.587201</td><td>0.711957</td></tr>
<tr><td></td><td>2</td><td>0.575491</td><td>0.555127</td><td>0.726165</td></tr>
<tr><td></td><td>3</td><td>0.551347</td><td>0.5452</td><td>0.730785</td></tr>
<tr><td></td><td>4</td><td>0.548335</td><td>0.540938</td><td>0.732486</td></tr>
<tr><td></td><td>5</td><td>0.538313</td><td>0.536894</td><td>0.733644</td></tr>
<tr><td>2</td><td>1</td><td>0.535068</td><td>0.535683</td><td>0.73573</td></tr>
<tr><td></td><td>2</td><td>0.516119</td><td>0.523915</td><td>0.741325</td></tr>
<tr><td></td><td>3</td><td>0.516364</td><td>0.522218</td><td>0.742113</td></tr>
<tr><td></td><td>4</td><td>0.508947</td><td>0.51653</td><td>0.744895</td></tr>
<tr><td></td><td>5</td><td>0.500656</td><td>0.514619</td><td>0.746609</td></tr>
<tr><td></td><td>6</td><td>0.490499</td><td>0.511588</td><td>0.74738</td></tr>
<tr><td></td><td>7</td><td></td><td></td><td></td></tr>
<tr><td>3</td><td>1</td><td>0.499408</td><td>0.509486</td><td>0.748527</td></tr>
<tr><td></td><td>2</td><td>0.489586</td><td>0.509366</td><td>0.74936</td></tr>
<tr><td></td><td>3</td><td>0.486146</td><td>0.5088</td><td>0.749511</td></tr>
<tr><td></td><td>4</td><td>0.489602</td><td>0.507902</td><td>0.749174</td></tr>
<tr><td></td><td>5</td><td>0.485432</td><td>0.507049</td><td>0.749718</td></tr>
<tr><td>4</td><td>1</td><td>0.483158</td><td>0.504774</td><td>0.751661</td></tr>
<tr><td></td><td>2</td><td>0.477729</td><td>0.500665</td><td>0.753739</td></tr>
<tr><td></td><td>3</td><td>0.484929</td><td>0.501044</td><td>0.753325</td></tr>
<tr><td></td><td>4</td><td>0.47441</td><td>0.497946</td><td>0.755435</td></tr>
<tr><td></td><td>5</td><td>0.475028</td><td>0.495898</td><td>0.756214</td></tr>
<tr><td></td><td>6</td><td>0.469361</td><td>0.495856</td><td>0.756346</td></tr>
<tr><td></td><td>7</td><td>0.475626</td><td>0.495669</td><td>0.756536</td></tr>
</table>
</noscript>

You’ll notice that there’s a data point missing at the end of the second set of epochs. The Jupyter notebook had a bit of an issue here, and though the training finished successfully, the loss and metric output didn’t make it to the screen. Frustrating, but this is one of the dangers of using Jupyter for long lived training runs.

## Processing the Output

With the training runs finished, the next step was to test against in the validation set. At this stage I need per business, rather than per photo, F1. More processing is needed.

Remember before when I said my use of pandas was far from elegant and idiomatic? Well… look away now if that bothered you, because it’s about to get a lot worse. One of the dangers of Python is that it’s really easy to use it as a write only language. You can put a lot of power into a single line of code which makes no sense to you about an hour later.

Well... my quickly hacked together solution for matching photos to businesses in the validation set is one of those times. It uses a series of three dictionary comprehensions to to map the index of each photo in the validation *photo* set to the index of the appropriate business in the validation *business* set.

```python
# Map the ids of businesses in the business validation set to their
# index in that set. 
val_biz_ids = {biz_to_labels_data.loc[val_biz_idxs[i], 'business_id'] : i
			   for i in range(len(val_biz_idxs))}
# Map the ids of photos in the photo validation set to their index
# in that set.
val_photo_ids = {joined.iloc[val_idxs[i], -4] : i for i in range(len(val_idxs))}

# Map index in the photo validation set to index in the business validation
# set.
photo_idx_to_val_biz_idx = {val_photo_ids[joined.iloc[i, -4]] :
							val_biz_ids[joined.iloc[i, -3]] for i in val_idxs}
```

With that done, I wrote a new method which first builds the per business predictions. I originally tried two approaches to this: taking the maximum of the predicted values for each class; and taking the mean of the predicted values. After a little bit of experimentation, I found that the mean[^4] gave better results.

```python
def photo_to_biz(preds, targs):
	
	# Initial storage for predications and targets.
	biz_preds = np.zeros((len(val_biz_idxs), preds.shape[1]))
	biz_targs = np.zeros((len(val_biz_idxs), targs.shape[1]))
	# Counts of the number of photos observed for each business.
	# Used to calculate a rolling average.
	biz_counts = {}
	
	for val_idx in range(preds.shape[0]):
		biz_idx = photo_idx_to_val_biz_idx[val_idx]
		
		# Update the number of photos seen for this business.
		biz_count = biz_counts.get(biz_idx, 0) + 1
		biz_counts[biz_idx] = biz_count

		# Update the rolling mean of the predictions.
		frac = ((biz_count-1) / biz_count)
		biz_preds[biz_idx,:] = (biz_preds[biz_idx,:] * frac) + (preds[val_idx,:] / biz_count)
		
		# Use max to update the target values.
		# (Technically this only needs to be done once for each
		# business and could be precalculated).
		biz_targs[biz_idx,:] = np.maximum(biz_targs[biz_idx,:], targs[val_idx,:])

	return biz_preds, biz_targs
```

The output can then be fed into the F1 calculation above. Surprisingly (to me), the per-business F1 score actually same out higher than the per photo score. `0.7845` vs `0.7565`, which is a notable improvement. 

Not quite good enough to hit my goal, though.

Next time: Dirty hacks, improvements galore, submitting to Kaggle, and graphs. Lots of graphs. You can read it [here](https://harveynick.com/2018/06/30/kaggles-yelp-restaurant-photo-classification-competition-fast-ai-style-part-2/).

[^1]:	As he is fond of doing.

[^2]:	Meaning that it always returns the same same output given the same input.

[^3]:	It’s actually more complicated that than, but as I noted above: that’s not important right now.

[^4]:	Again, this might not be the case for other datasets. I used a rolling calculation of the mean. This code could be made a little simpler by pre-counting the number of photos for each business. 