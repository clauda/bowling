class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :only => %w(new create edit update destroy show)
  before_filter :load_categories, :only => %w(index new create edit update)

  def index
    @posts = Post.published.paginate :page => params[:page]
    @posts = Post.search(params[:search]).paginate(:page => params[:page]) if params[:search].present?
    respond_with @posts
  end

  def show
    @post = Post.find(params[:id])
    respond_with @post
  end

  def permalink    
    @post = Post.find_by_slug(params[:slug])
    render "show"
  end

  def new
    @post = Post.new(:user => current_user)
    render :layout => 'admin'
  end

  def edit
    @post = Post.find(params[:id])    
    render :layout => 'admin'
  end

  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    @post.tag_list << params[:post][:tag_list].split(",") if params[:post][:tag_list]
    respond_to do |format|
      if @post.save
        format.html { redirect_to(admin_post_path, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new", :layout => 'admin' }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        @post.tag_list << params[:post][:tag_list].split(",") if params[:post][:tag_list]
        @post.save
        format.html { redirect_to(admin_post_path, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit", :layout => 'admin' }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end
  
  def publish
    @post = Post.find(params[:id])
    @post.draft = false
    @post.published_at = Time.now
    flash[:notice] = "Published"
    @post.save
    respond_with @post
  end

  def tags
    @posts = Post.tagged_with(params[:name]).paginate(:page => params[:page])
    render "index"
  end

protected
  def load_categories
    @categories = Category.all
    @category   = Category.find(params[:category_id]) if params[:category_id]
  end

end
