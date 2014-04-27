# Title: Simple Video tag for Jekyll
# Author: Brandon Mathis http://brandonmathis.com
# Description: Easily output MPEG4 HTML5 video with a flash backup.
#
# Syntax {% video url/to/video [width height] [url/to/poster] %}
#
# Example:
# {% video http://site.com/video.mp4 720 480 http://site.com/poster-frame.jpg %}
#
# Output:
# <video width='720' height='480' preload='none' controls poster='http://site.com/poster-frame.jpg'>
#   <source src='http://site.com/video.mp4' type='video/mp4; codecs=\"avc1.42E01E, mp4a.40.2\"'/>
# </video>
#

module Jekyll

  class YouTubeTag < Liquid::Tag
    @source = nil
    @height = ''
    @width = ''

    def initialize(tag_name, markup, tokens)
      if markup =~ /(([a-zA-Z0-9])(\S+))(\s+(\d+)\s(\d+))?/i
        @source = $1
        @width  = $5
        @height = $6

      end
      super
    end

    def render(context)
      output = super
      if @source
        video = "<iframe src=\"http://www.youtube.com/embed/#{@source}\" width=\"#{@width}\" height=\"#{@height}\" frameborder=\"0\" allowfullscreen></iframe>"
      else
        "Error processing input, expected syntax: {% youtube video_id [width height] %}"
      end
    end
  end
end

Liquid::Template.register_tag('youtube', Jekyll::YouTubeTag)

