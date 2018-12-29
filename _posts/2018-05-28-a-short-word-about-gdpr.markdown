---
layout: article
title: A Short Word About GDPR
date: '2018-05-28 14:11:48'
tags:
- blogger
- hacker
---

If you’re not dead and you’ve been on the internet recently, you’ve probably head about GDPR. Given the circumstances of you reading this article, I’m going to assume that both of those things are true. [GDPR](https://ec.europa.eu/commission/priorities/justice-and-fundamental-rights/data-protection/2018-reform-eu-data-protection-rules_en), which of course stands for <del>Google Democratic People’s Republic</del> General Data Protection Regulation, is a new law in the EU. The gist of it is this: you’re data belongs to you; you get to choose who has it; you get to choose how it is used.

Without fear of breaking my NDA, I think I can say that GDPR led to a lot of internal effort at Google. Perhaps not quite as much as you would think. Google does genuinely try to be a good steward of its users’ data. But still, there was effort, and possibly the biggest nexus around which that effort revolved is Google’s advertising business.

Most of the commentary on GDPR amounted to it being an annoyance for large businesses and a burden for smaller ones. Some smaller companies have [stopped doing business](https://gdprhallofshame.com/14-you-have-been-terminated/) in the EU permanently (or so they say). Some lightbulbs have stopped working in the EU ([not kidding](https://gdprhallofshame.com/7-sorry-your-light-bulbs-and-gdpr-dont-work/)). Some US news websites are [currently blocked](https://gdprhallofshame.com/13-what-if-we-did-nothing/)[^1], and USA today actually [threw up](https://twitter.com/fr3ino/status/1000166112615714816?s=19) an EU only ad free version of the site[^2]. 

There is also some effect on small blogs such as this one. At least: some effect on small blogs such as this one… which happen to use use Google AdSense. Google has actually made it the publisher’s responsibility to get consent for showing personalised advertising. Why would a publisher want to do that? Well, let me illustrate by showing the “tracking type” distribution for the tiny amount of AdSense revenue I’ve made via this site:

<div class="wide">
  <canvas id="targetting"></canvas>
</div>
<script>
  var barChartData = {
    labels: [
      'Personalised',
      'Contextual',
      'Run of Network',
      'None',
      'Placement',
    ],
    datasets: [{
      label: 'Earnings',
      backgroundColor: [
        'rgb(255, 99, 132)',
        'rgb(54, 162, 235)',
        'rgb(255, 205, 86)',
        'rgb(75, 192, 192)',
        'rgb(201, 203, 207)'],
        data: [ 4.44, 3.03, 0.04, 0.01, 0.00 ],
    },]
  };
  window.onload = function() {
    var ctx = document.getElementById('targetting').getContext('2d');
    new Chart(ctx, {
      type: 'bar',
      data: barChartData,
      options: {
        responsive: true,
        legend: { display: false, },
        tooltips: {mode: 'nearest', intersect: false, },
        hover: { mode: 'nearest', intersect: false, },
        title: {
            display: true,
            text: 'Earnings by Targetting Type',
        },
        scales: {
          yAxes: [{ scaleLabel: { 
            display: true,
            labelString: "GBP (£)",
            padding: 0,
          }, }],
        },
      }
    });
  };
</script>
<noscript>
  <table>
    <tr> <th>Targetting Type</th> <th>Estimated Earnings</th> </tr>
    <tr> <td>Personalised</td>    <td>£4.44</td> </tr>
    <tr> <td>Contextual</td>      <td>£3.03</td> </tr>
    <tr> <td>Run of Network</td>  <td>£0.04</td> </tr>
    <tr> <td>None</td>            <td>£0.01</td> </tr>
    <tr> <td>Placement</td>       <td>£0.00</td> </tr>
  </table>
</noscript>

As you can see well over half of this tiny amount of money has come from personalised ads[^3]. If this was my main source of income you could see why I might want to keep showing ads with personalised targeting. It isn’t, though. Also: in order to keep showing them I’d have to ask each user if they’re okay with it. Then I’ve have to store that information somewhere, probably with a cookie. I do not want any part of [using cookies](https://ico.org.uk/for-organisations/guide-to-pecr/cookies-and-similar-technologies/).

Where I’m going with this, dear reader, is that I’ve gone ahead and made the decision on your behalf. Sincere apologies if you do wish to be tracked, and see adverts which are more relevant to you on all of the websites you visit. However I’ve decided that actually I’d prefer the readers of this site not be tracked. So, as per Google’s instructions, I’ve added the following line of code to the ad unit which is shown on this site:

```js
(adsbygoogle=window.adsbygoogle||[]).requestNonPersonalizedAds=1
```

The upshot of this is that you should never see personalised ads when reading this site.

[^1]:	What the hell are you doing with our data, guys?

[^2]:	It’s wonderful. Just HTML and CSS. I wish this is what all news websites were like.

[^3]:	Personalised and contextual targeting are somewhat straightforward. “Run of network” is remarking (you put these shoes in your basket but didn’t buy them), I think. Placement means someone specifically placed an ad on my site. I don’t have that enabled (I think?), so it makes sense that it’s zero. “None” is a puzzling one, though. It’s not included in the [AdSense definitions](https://support.google.com/adsense/answer/1055502?hl=en-GB). I guess there are circumstances under which an ad is selected randomly?!