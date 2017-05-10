module SessionsHelper
# #4  create_session sets user_id on the session object to user.id, which is unique for each user
   def create_session(user)
     session[:user_id] = user.id
   end

 # #5  clear the user id on the session object by setting it to nil
   def destroy_session(user)
     session[:user_id] = nil
   end

 # #6  define current_user, which returns the current user of the application.  current_user encapsulates the pattern of finding the current user that we would otherwise call throughout Bloccit
   def current_user
     User.find_by(id: session[:user_id])
   end
end
