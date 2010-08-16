module ApplicationHelper
  include TweetButton

  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each do|type|
      if flash[type]
        messages= raw("<div class='#{type}'>#{flash[type]}</div>")
      end
    end
    messages
  end

end
