class Admin::PostsController < Admin::ApplicationController
  before_filter :get_posts, only:  [:index]
  before_filter :get_post, except: [:index, :new, :create]

  def index
    respond_to do |format|
      format.html
      format.json { render json: @posts, status: :ok }
      format.xml { render xml: @posts, status: :ok }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @post = Post.new(params[:post])
    @post.user_id = current_user.id if defined? current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to edit_admin_post_path(@post), notice: 'Created post.' }
        format.json { render json: @post, status: :created }
        format.xml { render xml: @post, status: :created }
      else
        format.html { render 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.xml { render xml: @post.errors, status: :unporcessable_entity }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to edit_admin_post_path(@post), notice: 'Updated post.' }
        format.json { render json: @post, status: :ok }
        format.xml { render xml: @post, status: :ok }
      else
        format.html { render 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.xml { render xml: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: 'Post deleted.' }
      format.json { render json: @post, status: :deleted }
      format.xml { render xml: @post, status: :deleted }
    end
  end

  private

  def get_posts
    @posts = Post.all || []
  end

  def get_post
    @post = Post.find(params[:id]) || nil
  end
end