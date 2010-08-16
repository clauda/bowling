class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource
  respond_to :html, :xml, :json  
  
  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

end
