module UsersHelper
  def user_has_posts?
    self.posts.any?
  end

  def user_has_comments?
    self.comments.any?
  end
end
