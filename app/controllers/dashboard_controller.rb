class DashboardController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:index]

  def index
    @posts = Post.all.paginate :page => params[:page]
    @categories = Category.all
    render :layout => 'admin'
  end

  def post
    @post = Post.find(params[:id])
    render :layout => 'admin'
  end

  def about
  end

end
