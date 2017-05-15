class FavoriteMailer < ApplicationMailer
  default from: "jjw244@utexas.edu"

  def new_comment(user, post, comment)

# #18  set three different headers to enable conversation threading in different email clients
    headers["Message-ID"] = "<comments/#{comment.id}@bloccit-jw>"
    headers["In-Reply-To"] = "<post/#{post.id}@bloccit-jw>"
    headers["References"] = "<post/#{post.id}@bloccit-jw>"

    @user = user
    @post = post
    @comment = comment

# #19  the mail method takes a hash of mail-relevant information - the subject the  to address, the from (we're using the default), and any cc or bcc information - and prepares the email to be sent
    mail(to: user.email, cc: "beaugaines@yahoo.com", subject: "New comment on #{post.title}")
  end

  def new_post(user, post)

    headers["Message-ID"] = "<posts/#{post.id}@bloccit-jw>"
    headers["In-Reply-To"] = "<post/#{post.id}@bloccit-jw>"
    headers["References"] = "<post/#{post.id}@bloccit-jw>"

    @user = user
    @post = post

    mail(to: user.email, cc: "beaugaines@yahoo.com", subject: "New post on #{post.title}")
  end
end
