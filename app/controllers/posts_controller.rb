class PostsController < ApplicationController
  def index
# #11 declare an instance variable and assign it a collection of Post objects using the all method provided by ActiveRecord
    @posts = Post.all

    @posts.all.each_with_index do |post, index|
      if index % 5 == 0
        post.title = "SPAM"
      end
    end
  end

  def show
# #19  find the post that corresponds to the id in the params that was passed to  show and assign it to @post
  # Unlike in the index method, in the show method, we populate an instance variable with a single post, rather than a collection of posts
    @post = Post.find(params[:id])
  end

  def new
  # #7  create an instance variable, @post, then assign it an empty post returned by Post.new
    @post = Post.new
  end

  def create
# #9  call Post.new to create a new instance of Post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

# #10 if Post is successfully saved (see #11); Redirecting to @post will direct the user to the posts show view
    if @post.save
# #11  assign a value to flash[:notice]. The flash hash provides a way to pass temporary values between actions. Any value placed in flash will be available in the next action and then deleted
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
# #12  if not, we display an error message and render the new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
  end
end
