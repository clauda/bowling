class CategoriesController < ApplicationController
  
  before_filter :authenticate_user!

  def create
    @category = Category.new(params[:category])
    flash[:alert] = 'Fail!' unless @category.save
    redirect_to dashboard_path
  end
 
end
