class PostsController < ApplicationController
  def index
# #11 declare an instance variable and assign it a collection of Post objects using the all method provided by ActiveRecord
    @posts = Post.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
