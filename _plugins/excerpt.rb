
#<!-- This snippet checks for an excerpt variable that I assign to true on my index pages, but not on the post pages, then checks to see if the post has an excerpt to see if it should render the excerpt of the post or the whole thing -->
#<div class="entry">
#  {% if excerpt and post.excerpt %}
#    {{ post.excerpt }}
#    <p> <a href="{{ post.url }}/#more" class="more-link"><span class="readmore">Read the rest of this entry »</span></a></p>
#  {% else %}
#    {{ post.content | mark_excerpt }}
#  {% endif %}
#</div>


# This goes in _plugins/excerpt.rb
module Jekyll
  class Post
    alias_method :original_to_liquid, :to_liquid
    def to_liquid
      original_to_liquid.deep_merge({
        'excerpt' => content.match('<!--more-->') ? content.split('<!--more-->').first : nil
      })
    end
  end
  
  module Filters
    def mark_excerpt(content)
      content.gsub('<!--more-->', '<p><span id="more"></span></p>')
    end
  end
end