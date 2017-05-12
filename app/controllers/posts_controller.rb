class PostsController < ApplicationController
  before_action :require_sign_in, except: :show
# #10 use a second before_action filter to check the role of a signed-in user.
 # If the current_user isn't authorized based on their role, we'll redirect them to the posts show view
  before_action :authorize_user, except: [:show, :new, :create]

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
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
# #14  assign @post.user in the same way we assigned @post.topic, to properly scope the new post
    @post.user = current_user

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
    @post.assign_attributes(post_params)

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

# remember to add private methods to the bottom of the file. Any method defined below private, will be private.
  private
  def post_params
    params.require(:post).permit(:title, :body)
  end

   def authorize_user
     post = Post.find(params[:id])
# #11 redirect the user unless they own the post they're attempting to modify, or they're an admin
   unless current_user == post.user || current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to [post.topic, post]
    end
  end
end
