class PostsController < ApplicationController
  layout 'application'
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def new
    @post = Post.new
  end

  def show
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Article succesfully saved!"
    else
      render 'new', notice: "Try Again. I was unable to save your post."
    end
  end

  def edit
  end

  def update

    if @post.update(params[:post].permit(:title, :body))
      redirect_to @post, notice: "Article succesfully edited!"
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :slug, :bootsy_image_gallery_id)
  end

  def find_post
    @post = Post.friendly.find(params[:id])
  end
end