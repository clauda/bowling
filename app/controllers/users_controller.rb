class UsersController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = current_user.users.new(params[:user])
    
    respond_to do |format|
      if @user.save
          format.html { redirect_to @user, :notice => t(:created, :model => t('User')) } 
          format.xml { render :xml => @user, :status => :created, :location => @user }
      else
          format.html { render :action => "new"}
          format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end      
  end
  
  def update
    @user = User.find(params[:id])
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
          format.html { redirect_to @user, :notice =>  t(:updated, :model => t('User'))}
          format.xml { render :xml => @user, :status => :updated, :location => @user }
      else
          format.html { render :action => "edit" }
          format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    respond_to do |format|
      format.html { redirect_to users_url }
    end
  end

end
