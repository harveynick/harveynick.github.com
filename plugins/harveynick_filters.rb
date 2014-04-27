module HarveyNickFilters
  def get_indefinate_article(input)
    if /^[aeiou]/.match(input)
      "an"
    else
      "a"
    end
  end
  
  def with_indefinate_article(input)
    "#{get_indefinate_article(input)} #{input}"
  end
  
  def urlify(input)
    input.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase
  end

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