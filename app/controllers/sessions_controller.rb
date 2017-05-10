class SessionsController < ApplicationController
  def new
  end

  def create
# #1  search the database for a user with the specified email address in the  params hash
    user = User.find_by(email: params[:session][:email].downcase)

# #2  verify that user is not nil and that the password in the params hash matches the specified password
    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = "Welcome, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

#  destroy logs the user out by calling destroy_session(current_user),
 # flashes a notice that they've been logged out, and redirects them to root_path
  def destroy
# #3  This method will delete a user's session
    destroy_session(current_user)
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_path
  end
end
