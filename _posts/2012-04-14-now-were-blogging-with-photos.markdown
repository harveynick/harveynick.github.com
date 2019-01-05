---
layout: post
title: Now We're Blogging with Photos!
date: '2012-04-14 08:42:00'
image: http://images.harveynick.com/2012-05-17-wandering-around-london_IMG_0450.jpg
tags:
- blogger
- hacker
---

*Fair warning: this is going to be a bit of a programming heavy blog post. It's also going to be quite Mac specific.*

One of the things I wanted to change about the format of this blog was to make it more visual, specifically with pictures. This first part of this was to add pictures to the front page. There were a couple of options for doing so. I could just scan through an article, look for the first image tag and use this. Alternatively I could add a mechanism which allowed me to choose the image, in a similar manner to the way [Octopress] allows me to choose the except which appears on the front page. I decided to go with option two. 

<!-- More -->

The first part of this was to modify the image tag plug-in like so:

[Octopress]: http://octopress.org/

```ruby
module Jekyll

  class ImageTag < Liquid::Tag
    @img = nil
    @header = "" 

    def initialize(tag_name, markup, tokens)
      attributes = ['class', 'src', 'width', 'height', 'title']

      if markup =~ /(?<class>\S.*\s+)?(?<src>(?:https?:\/\/|\/|\S+\/)\S+)(?:\s+(?<width>\d+))?(?:\s+(?<height>\d+))?(?<title>\s+.+)?/i
        @img = attributes.reduce({}) { |img, attr| img[attr] = $~[attr].strip if $~[attr]; img }
        if /(?:"|')(?<title>[^"']+)?(?:"|')\s+(?:"|')(?<alt>[^"']+)?(?:"|')/ =~ @img['title']
          @img['title']  = title
          @img['alt']    = alt
        else
          @img['alt']    = @img['title'].gsub!(/"/, '&#34;') if @img['title']
        end
        @img['class'].gsub!(/"/, '') if @img['class']
        if tag_name == "header_img"
          @header = "<!-- header_img #{@img['src']} -->"
        end
      end
      super
    end

    def render(context)
      if @img
        "<img #{@img.collect {|k,v| "#{k}=\"#{v}\"" if v}.join(" ")}>#{@header}"
      else
        "Error processing input, expected syntax:  img [class name(s)] [http[s]:/]/path/to/image [width [height]] [title text | \"title text\" [\"alt text\"]] "
      end
    end
  end
end

Liquid::Template.register_tag('img', Jekyll::ImageTag)
Liquid::Template.register_tag('header_img', Jekyll::ImageTag)
```

This adds an `html` comment containing the image path to the page when I use `header_img` as a [Liquid] tag name rather than the original `img`. Next I need to do something with this comment. I created an additional Liquid filter which pulls the path out and replaces it with an actual image embed:

[Liquid]: https://github.com/Shopify/liquid/wiki

```ruby
module HarveyNickFilters

  # Used on the blog index to split posts on the <!--more--> marker
  def header_image(input)
    if input =~ /<!-- header_img (?<src>(?:https?:\/\/|\/|\S+\/)\S+) -->/
      "<img class=\"header\" src=\"#{$~['src']}\"/>"
    else
      ""
    end
  end
end

Liquid::Template.register_filter(HarveyNickFilters)
```

Next I modified my theme to run this filter over the page contents just before the one which creates the except on the front page. I'll leave this as an exercise for the reader. Lastly, I needed to account for the fact that the created image could be just about any size, while I want some uniformity on the front page. Those of you playing at home will have noticed I assigned `header` as the class of the image. This allows me to control the appearance of the front page images by adding the following to the `sass` files in my theme (which are used to generate the `css`):

```scss
img {
  &.header{
    float: left;
    width: 250px;
    max-width: 50%;
    margin-right: 10px;
    margin-bottom: 10px;
    @media only screen and (max-width: 768px) {
      width: 50%;
      max-width: 250px;
    }
    @media only screen and (max-width: 400px) {
      width: 100%;
      max-width: 100%;
      margin-right: 0px;
    }
  }
}
```

Presto. Front page images.

Next, I wanted to try and make it easier to include pictures which I myself have taken with an actual camera (or, more likely, my phone). There really isn't any problem when you're linking to images elsewhere on the internet, but things can get a bit stickier when you want to include your own images on an Octopress blog. One option is to use a hosted service, like Flickr or PhotoBucket, but this only works when you have an internet connection. I really love that Octopress allows me to work on my site while offline, and I didn't want to lose this advantage when I'm posting pictures. Thus, I decided to just stick the images in my blog's images folder.

iPhoto is pretty great for organising and sharing photos (with supported services), but definitely doesn't make your life easy if you want to actually get at the image files themselves. That's the first problem. The second is that I also want to resize them to something reasonable for my blog. Lastly I want this to be low hassle. I came to the conclusion that an [Applescript] is what was required, and this is what I came up with:

[Applescript]: http://en.wikipedia.org/wiki/AppleScript

```applescript
set blog_path to "~/GitHub/octopress/source"
set images_path to "/images/blog/"
set blog_image_path to blog_path & images_path
set max_width to 992

set {year:y, month:m, day:d} to (current date)
set date_string to "" & y & "/" & two_digits(m * 1) & "/" & two_digits(d)
set folder_path to blog_image_path & date_string & "/"

do shell script "mkdir -p " & folder_path

tell application "iPhoto"
  set the_photos to selection
  set the_photo to item 1 of the_photos
  set image_path to image path of the_photo
  set image_name to name of the_photo
end tell

tell application "Image Events"
  set current_image to open image_path
  set image_type to current_image's file type
  set AppleScript's text item delimiters to "/"
  set image_path to last item of text items of image_path
  set AppleScript's text item delimiters to ""
  scale current_image to size max_width
  set new_image to folder_path & image_path
  save current_image in new_image as image_type
end tell

set the clipboard to images_path & date_string & "/" & image_path

on two_digits(the_number)
  return (text -2 thru -1 of ((the_number + 100) as string))
end two_digits
```

Now, Applescript the programming language is completely mental and can be a complete pain in the arse to get right, but Applescript the mechanism is spectacularly powerful. You can do some serious automation with it. This script grabs the path to the currently selected photograph in iPhoto, resizes it and copies it to a folder inside my blog, generated using today's date to avoid duplication. Lastly, it places the location of the image on the clipboard, in the form it's needed.

To use it, I enabled the scripts menu (it's an option in the Applescript editor) and copied the script to the iPhoto scripts folder, which will be something like `/Users/<user>/Library/Scripts/Applications/iPhoto`. This might be hidden by default, but you can find it via the scripts menu while in iPhoto.

Then, all that is required is to select a photo, trigger the script, and then hit cmd-c in the post I'm writing. Bingo!

After getting this working, I remembered an [ArsTecnica article] about using [Ruby] in place of Applescript for this purpose, so I converted the script to Ruby as an exercise. This is what I came up with:

[ArsTecnica article]: http://arstechnica.com/apple/guides/2011/09/tutorial-os-x-automation-with-macruby-and-the-scripting-bridge.ars/2
[Ruby]: http://www.ruby-lang.org/en/

```ruby
#!/usr/local/bin/macruby  
  
framework "ScriptingBridge"

blog_path = "~/GitHub/octopress/source"
images_path = "/images/blog/"
max_width = 992
convert = "/opt/local/bin/convert"

date_string = Time.now.strftime("%Y/%m/%d")

source_path = SBApplication.applicationWithBundleIdentifier("com.apple.iPhoto").selection[0].imagePath.sub(" ", "\\ ")
image_name = source_path.split("/")[-1]
destination_folder = "#{blog_path}#{images_path}#{date_string}".sub(" ", "\\ ")
destination_path = "#{destination_folder}/#{image_name}"

ensure_dir_cmd = "mkdir -p #{destination_folder}" 
puts ensure_dir_cmd 
system ensure_dir_cmd


convert_cmd = "#{convert} #{source_path} -resize #{max_width}x2000 #{destination_path}" 
puts convert_cmd
system convert_cmd 

IO.popen('pbcopy', 'w').print "#{images_path}#{date_string}/#{image_name}"
```

Ruby is a much more sensible language, and this, to me, is a lot easier to follow. I'm fairly new to Ruby, so this might not actually be the most Ruby-ish way of doing it, mind. It should be noted that it will only work with [MacRuby], though. You will also need [ImageMagick] installed. I made this executable with a quick `chmod +x` and moved it to the iPhoto scripts folder as well, where it seems to work just fine. So now I have two options. Hopefully, someone out there finds this useful.

[MacRuby]: http://www.macruby.org/
[ImageMagick]: http://www.imagemagick.org/script/index.php

Finally, to prove it works, and because it feels a little strange to not actually have any pictures in this entry: here's a nice shot taken at Kew Gardens (which hopefully I'll talk about more later):

![](http://images.harveynick.com/2012-05-17-wandering-around-london_IMG_0450.jpg) 