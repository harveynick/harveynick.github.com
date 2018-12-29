---
layout: post
title: An iOS Developer’s Opinions of Flutter
date: '2018-05-21 17:18:24'
tags:
- hacker
---

Around a year ago I led a team which spent several months building a complete app using [Flutter](https://flutter.io). For various reasons (none of which I can go into) this app did not ship, and I moved on to a different role. More recently, I spent a week participating in a [hackathon](https://en.m.wikipedia.org/wiki/Hackathon). The team I was part of built a successful proof of concept inside an existing app using Flutter.

As a result, Flutter is kind of on my mind right now. I’d like to take the opportunity to put my thoughts down in words. As it turns out, my thoughts on this are quite lengthy. If two and a half thousand words sounds like too much, you can find the TLDR above.

## Who Exactly am I?

Since I’m expressing an opinion, I think it’s worth laying out my experience in relevant areas. Presently I’m mostly a front end web developer at Google, where (at the time of writing) I have been employed for almost exactly 7 years. As such the current tools of my trade are JavaScript (using Google’s [Closure](https://developers.google.com/closure/) compiler), CSS and HTML.

I originally started my Google career as a backend developer. About a year into that I incepted, coded, and shipped the [Google AdSense App for iPhone](https://itunes.apple.com/us/app/google-adsense/id680739529?mt=8). Up until the most recent releases (which has an additional contributer[^1]) I was responsible for every line of (non-library) code in the app. After that I moved to the Google Calendar team and helped ship the v1 of [Google Calendar for iOS](https://itunes.apple.com/us/app/google-calendar/id909319292?mt=8). At the time I left that team I was responsible for the architecture of about 80% of the UI, and all of the animations in the app. I also worked on several of Google’s internal UI libraries for iOS. The last time I looked I had contributed around 500k lines of [Objective-C](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html) to Google’s codebase.

I have scant experience of coding for Android, but at *lot* of experience of using the Java programming language, having previously been a backend developer, and using it extensively during my PhD.

On the whole I enjoy coding for iOS a great deal. In fact I still play with coding iOS Apps in [Swift](https://developer.apple.com/swift/) during my spare time. I enjoy web development less, and Android development much less still. I also enjoy science fiction TV shows and American style barbecue, but that’s not important right now. 


## What is Flutter?

Flutter is essentially two things:

1. A cross platform framework which allows you to build an app once and then ship it on both Android and iOS;
2. The UI framework used by Google’s in development [Fuchsia](https://en.m.wikipedia.org/wiki/Google_Fuchsia) operating system.

You could probably make the case that it’s actually a cross platform UI framework which allows you build for three operating systems, including one which doesn’t entirely exist yet.

To talk about it more deeply I’m going to break it down into three subareas: the programming language, the APIs, and the renderer. Small warning before we start: this is going to be something of a reverse shit sandwich. Perhaps not quite that extreme, but the filling is definitely a lot better than the bread.


### Anatomy of Flutter Part 1: The Dart Programming Language

[Dart](https://www.dartlang.org) was conceived at Google as, essentially, [a better JavaScript](http://radar.oreilly.com/2012/03/what-is-dart.html). It was intended to replace JavaScript as the web language of choice. Thus its design goals included that it should:
-  run on a reasonably sized virtual machine (or VM);
-  [transpile](https://en.m.wikipedia.org/wiki/Source-to-source_compiler) it to sensible JavaScript for use in browsers which lacked a Dart VM;
- appeal to JavaScript programmers.

Unfortunately, that “browsers which lack a Dart VM” part is what killed the original plan. The one browser the Dart team thought they could count on, Google Chrome, decided that it was already a little on the heavy side. The last thing it needed was to included a *second* virtual machine, especially on mobile platforms[^2].

That didn’t actually kill the use of the language, though. The “transpile to JavaScript” aspect remained alive, and it evolved into a peer of [TypeScript](http://www.typescriptlang.org) and [CoffeeScript](http://coffeescript.org). It remains in active use both inside and outside of Google.

Originating as a planned alternative to JavaScript, in its original form it was extremely dynamic. Type annotations were an option the programmer could chose to add. Later more concrete static typing was added in the form of “strong mode”, which become the default as of the [2.0 release](https://www.dartlang.org/dart-2). 

I would describe Dart as boring, but in a good way. It’s neat, productive, and pleasant to use. These are the only exciting things about it. Again: this is not a bad thing. Aside from some very neat [constructor syntax](https://www.dartlang.org/guides/language/language-tour#constructors) and perhaps the [cascade operator](https://www.dartlang.org/guides/language/language-tour#cascade-notation-), you are unlikely to be surprised by the content of a Dart codebase.

When I move from Swift to Dart I find myself missing Swift’s [optionals](https://developer.apple.com/documentation/swift/optional), [enums](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html), [value types](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html) and [weak references](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html). On the other hand, Dart has language level asynchronous functionality in the form of [async/await](https://www.dartlang.org/guides/language/language-tour#asynchrony-support), which is currently only a [proposal](https://gist.github.com/lattner/429b9070918248274f25b714dcfc7619) for Swift. I think Dart also has a shallower learning curve than Swift, as there is less to learn.

I would say I prefer Swift to Dart, but I prefer Dart to Java. I *definitely* prefer Dart to JavaScript. Dart is... fine. It’s a totally solid choice for a UI language. If you have a Dart based web codebase you can even share some business logic, in theory[^3].

I have no *direct* knowledge of this, but: it’s also a solid political choice. Using Java as the Android programming language has caused Google [more than a little bit of trouble](https://en.m.wikipedia.org/wiki/Oracle_America,_Inc._v._Google,_Inc.). I can see why a language which is both open source *and* stewarded by Google directly makes sense here.

### Anatomy of Flutter Part 2: The Flutter Framework

The Flutter UI APIs are very different to both [UIKit](https://developer.apple.com/documentation/uikit) and the [Android framework](https://developer.android.com/guide/platform/), being completely declarative in native. In Flutter you build your UI as an immutable tree of widgets, branches of which are then rebuilt in response to changes in state.

Consider a simple static text label. Using Swift and iOS that would look something like this:

```swift
let label = UILabel()
label.text = "Hello world!"
```

In Flutter it would look quite similar:

```dart
final label = Text("Hello world!");
```

The differences become more obvious when we want the displayed text to change. Here’s one way of doing that in Swift:

```swift
let label = UILabel()
label.text = "Hello world!"

func setText(text: String) {
  label.text = text
}
```

UIKit’s labels are mutable, making this very easy. Flutter’s `Text` widget is stateless and immutable, though. To update its value we’d need to wrap it in a `StatefulWidget` and do something like this:

```dart
class TextWidget extends StatefulWidget {

  @override
  TextWidgetState createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  String text = "hello world";

  void setText(String text) {
    // setState takes a function which updates the local state
    // as input, then rebuilds the tree from this point down.
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) => Text(text);
}
```

This is imperfect, however. There’s no good way to get hold of that setter on the state object. Instead we need to handle the change reactively, using something like a Dart [`Stream`](https://www.dartlang.org/tutorials/language/streams):

```dart
class TextWidget extends StatefulWidget {
  final Stream<String> textStream;

  // This is the neat constructor syntax I mentioned before.
  TextWidget(this.textStream);

  @override
  TextWidgetState createState() => TextWidgetState();
}

class TextWidgetState extends State<TextWidget> {
  String text = "hello world";

  @override
  void initState() {
    super.initState();
    // This will call [setText] whenever the contents of [textStream]
    // changes.
    widget.textStream.listen(setText);
  }

  void setText(String text) {
    // [setState] takes a function which updates the local state
    // as input, then rebuilds the tree from this point down.
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) => Text(text);
}
```

Perhaps a better Swift comparison would be to use [rxSwift](https://github.com/ReactiveX/RxSwift). That would look something like this:

```swift
let label = UILabel()
label.text = "Hello world!"
let textObservable: Observable<String?>
textObservable.bindTo(label.rx.text)
```

In either case: Flutter requires more code for these examples, but that’s because I’m leaving out some of the additional code which would be needed for UIKit. The Flutter is self contained, and it makes the state transforms much more explicit. In the UIKit example, anything which can get a reference to the label can modify its state. Not so for Flutter. The `Stream` is the only means by which the text can be updated. The `setState` method is the only means by which the local state and child widgets of a `StatefulWidget` can be updated in turn. That removes whole classes of bugs.

I’ve barely scratched the surface here. You can find much deeper and more complete explanations of how Flutter widgets work [on the official website](https://flutter.io/widgets-intro/). There are also specific guides for [Android](https://flutter.io/flutter-for-android/), [iOS](https://flutter.io/flutter-for-ios/) and [Web](https://flutter.io/web-analogs/) developers.

For the most part, I really like this approach to building apps. Some things (infinite scrolling, for example) can be quite hard to achieve with the built-in widgets. I’ve also found a few apparently simple layouts which required complex solutions with Flutter. But here’s where Flutter has a strong advantage: it’s [open source all the way down](https://github.com/flutter/flutter). If one of the default widgets doesn’t quite do what you want, you can just fork the code and adjust it to meet your needs.

I find Flutter to be incredibly productive. I’m amazed at what the small team I worked with over the last week managed to get done. Across my experience of working with Flutter, I’ve also found that it does tend to produce fewer UI bugs. Where as UIKit pushes you towards an [MVC](https://en.m.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) approach to building an app, Flutter pushes you towards a [reactive](https://en.m.wikipedia.org/wiki/Reactive_programming) approach. This reduces the number of ways data can flow through the app, and makes it easier to reason about.

Comparing it to UIKit directly, I would say Flutter is close to on-par in terms of API quality. It is, however, significantly less comprehensive. This is hardly surprising. iOS and UIKit within it will ship its 12.0 version this year.  Flutter has not yet hit 1.0.


### Anatomy of Flutter Part 3: The Flutter Renderer

Now we get to the more controversial aspect of Flutter. That part which makes some mobile developers exclaim “What?! Gross!”

In my experience, people tend to put Flutter into the same mental box as [React Native](https://facebook.github.io/react-native/). Both are cross platform and both use what are usually thought of as “web languages”. Both strongly push users towards a reactive approach to data flow (obviously). That’s more or less where the comparisons end, however. React Native UIs use the system’s native components. So UIKit on iOS and Android Framework on Android. Flutter does not. It has its own OpenGL based renderer, and [creates its own UI components](https://flutter.io/faq/#does-flutter-use-my-systems-oem-widgets) completely from scratch. It handles user interaction directly, and has its own gesture handlers.

Within this sandbox, it emulates the look and feel of the host operating system user interface. In fact, there is a Flutter demo which allows the look and feel to be “flipped”, using iOS iconography and physics on Android and vice versa.

Here is one of the downsides of Flutter: In my opinion, and when built for iOS, this facsimile is imperfect. The UI looks just a *little* off. The scroll physics aren’t quite right. Animations don’t move in quite the way I would expect. It’s climbing the cliff at the other side of the uncanny valley, but not quite out of it. I have less experience of Android, so find it hard to make a comparison there. But I’m told it does a much better job[^4].

Another point which I think is worth bringing up: Unless you make a specific effort to have it be otherwise, an app built with Flutter will look almost identical on iOS and Android. Flutter will make only minimal changes (e.g. default font, back button icon, title justification) by default. There are the [“Cupertino” widgets](https://flutter.io/widgets/cupertino/) which mimic the iOS design language, built they lag behind iOS. In fact at the time of writing they do not appear to be up to date with iOS 11 which is more than 6 months old. That being the case: you’re probably looking at shipping a Material Design app if you use Flutter. Now, [I don’t think that’s necessarily a bad thing](https://harveynick.com/2016/06/06/material-design-and-ios/) on iOS, but it is worth baring in mind.


## Summation

I have to admit that I like developing with Flutter a great deal. Aside from a few frustrations it’s a genuinely great framework, though I wish its basis programming language was Swift, rather than Dart. I’m never completely happy with the app which results, however. I really, really wish Flutter produced native OS UI components, rather than its own OpenGL rendered widgets.

John Gruber’s [little birds tell him](https://daringfireball.net/2018/04/scuttlebutt_regarding_ui_project) Apple’s rumoured cross platform UI framework[^5] is based on a declarative paradigm. If that turns out to essentially be Flutter, but written with Swift and producing native OS UI components I will be absolutely *thrilled*. That would be a serious sweet spot, in my opinion.

If I was going to make a recommendations to the reader, they would be: 
* Consider using Flutter if you need to build a cross platform app, especially if you need to build for both iOS and Android in a hurry. Remember, though, that the differences between the platforms are more than fonts and scroll physics;
* If you’re building just an Android app it might also be worth considering. Android developers tell me the Flutter APIs are a step up from the Android UI APIs, and Android users tell me Flutter based Android apps feel totally solid;
* If you’re building for iOS: beware. Flutter apps don’t quite feel native to the platform. UIKit and something like [rxSwift](https://github.com/ReactiveX/RxSwift) might be a better option;
* If you’re really forward looking and want to build for [Fuchsia](https://en.m.wikipedia.org/wiki/Google_Fuchsia) (or whatever it ends up being called), then yes: definitely use Flutter. I suspect that’s *very* forward looking, though.

*Edit (22/05/2018): Added a link to the Flutter for iOS Developers resource, removed the `new` keyword from the Dart code and removed the *e* from Michał because spelling his name is even harder than I thought.*

[^1]:	S’up Michał, if you’re reading this. I hope you appreciate the ł.

[^2]:	Obviously I’m anthropomorphising here. Google Chrome is a piece of software. It does not make design decisions for itself. Yet.

[^3]:	The biggest issue I’m aware of here is that certain mathematical operations are not guaranteed to be identical when transpiled to JavaScript. 

[^4]:	This isn’t a knock against either Android or Flutter itself. It stands to reason that a team within Google would have an easier time reproducing the Android look and feel than the iOS look and feel. Need to quantify the scroll physics used by Android? Just look at the code. That’s not really an option for iOS.

[^5]:	Cross platform in this case meaning iOS and macOS, plus potentially tvOS and watchOS. The Apple ecosystem only.