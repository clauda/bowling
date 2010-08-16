class DashboardController < ApplicationController
  
  before_filter :authenticate_user!

  def index
    @posts = Post.all.paginate :page => params[:page]
    @categories = Category.all
  end

  def about
  end

end
