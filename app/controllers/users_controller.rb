class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
# #9  create a new user with new and then set the corresponding attributes from the params hash
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

# #10  save the new user to the database
    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

# #5  retrieve a user instance and set it to an instance variable
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
    @favorites = @user.favorites
  end
end
