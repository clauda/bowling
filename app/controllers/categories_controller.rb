class CategoriesController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:create]

  def posts_by_categories
    @category = Category.find_by_name(params[:name])
    @posts = @category.posts.paginate(:page => params[:page])
    render "posts/index"
  end

  def create
    @category = Category.new(params[:category])
    flash[:alert] = 'Fail!' unless @category.save
    redirect_to(dashboard_path)
  end
 
end
