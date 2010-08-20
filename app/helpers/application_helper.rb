module ApplicationHelper
  include TweetButton

  TweetButton.default_tweet_button_options = { :via => nil, :count => :horizontal }

  def flash_message
    flash.collect do |key, msg|
      content_tag(:div, msg, :id => "#{key}")
    end.join.html_safe
  end

  def error_messages_for(resource)
    render 'shared/error_messages', :resource => resource
  end

end
