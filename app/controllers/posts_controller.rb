class PostsController < ApplicationController
  def show
# #19  find the post that corresponds to the id in the params that was passed to  show and assign it to @post
  # Unlike in the index method, in the show method, we populate an instance variable with a single post, rather than a collection of posts
    @post = Post.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
  # #7  create an instance variable, @post, then assign it an empty post returned by Post.new
    @post = Post.new
  end

  def create
# #9  call Post.new to create a new instance of Post
    @post = Post.new
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]
    @topic = Topic.find(params[:topic_id])
 # #35  assign a topic to a post
    @post.topic = @topic

# #10 if Post is successfully saved (see #11); Redirecting to @post will direct the user to the posts show view
    if @post.save
# #11  assign a value to flash[:notice]. The flash hash provides a way to pass temporary values between actions. Any value placed in flash will be available in the next action and then deleted
      flash[:notice] = "Post was saved."
# #36  change the redirect to use the nested post path
      redirect_to [@topic, @post]
    else
# #12  if not, we display an error message and render the new view again
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.body = params[:post][:body]

    if @post.save
      flash[:notice] = "Post was updated."
# #37  change the redirect to use the nested post path
      redirect_to [@post.topic, @post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

# #8  call destroy on @post. If that call is successful, we set a flash message and redirect the user to the posts index view. If destroy fails then we redirect the user to the show view using render :show
    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
# #38  when a post is deleted, we direct users to the topic show view
      redirect_to @post.topic
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end
end
