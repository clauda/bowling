module ApplicationHelper
  include TweetButton

  TweetButton.default_tweet_button_options = {:via => nil}

  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each do|type|
      if flash[type]
        messages = raw("<div class='#{type}'>#{flash[type]}</div>")
      end
    end
    messages
  end

  #ISSUE: Not work
  def flash_message_nifty
    flash.each do |msg, name|
      content_tag(:div, msg, :class => "#{name}") if msg.is_a?(String)
    end
  end

end
