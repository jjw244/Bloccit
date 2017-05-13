module PostsHelper
  def user_is_authorized_for_post?(post)
    current_user && (current_user == post.user || current_user.admin? || current_user.moderator?)
  end

  def user_is_authorized_for_post_action?(post, action)
    if action == :delete
      authorized = current_user && (current_user == post.user || current_user.admin?)
    else
      authorized = current_user && (current_user == post.user || current_user.admin? || current_user.moderator?)
    end

    return authorized
  end
end
