class ProfilesController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def show
    @profile = current_user.profile
    render :layout => 'admin'
  end

  def new
    @profile = Profile.new
    render :layout => 'admin'
  end

  def edit
    @profile = current_user.profile
    render :layout => 'admin'
  end

  def create
    @profile = Profile.new(params[:profile])
    @profile.user = current_user
    respond_to do |format|
      if @profile.save
        format.html { redirect_to(profile_path, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new", :layout => 'admin' }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @profile = current_user.profile

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(profile_path, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => 'admin' }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
