require 'random_data'

# Create Users
5.times do
  User.create!(
# #3  wishful-coded two methods that we'll need to add to RandomData
  name:     RandomData.random_name,
  email:    RandomData.random_email,
  password: RandomData.random_sentence
  )
end
users = User.all

# Create Topics
15.times do
  Topic.create!(
    name:         RandomData.random_sentence,
    description:  RandomData.random_paragraph
  )
end
topics = Topic.all

# Create Posts
50.times do
# #1  Adding a ! instructs the method to raise an error if there's a problem with the data we're seeding
  Post.create!(
    user:   users.sample,
# #2  class RandomData attributes DNE yet -> "Whishful Coding" can increase productivity becasue it allows you to stay focused on one problem at a time
    topic:  topics.sample,
    title:  RandomData.random_sentence,
    body:   RandomData.random_paragraph
  )
end
posts = Post.all

# Create Comments
# #3  x.times runs a block x times
100.times do
  Comment.create!(
# #4  call sample on Post.all array inorder to pick a random post to associate each comment with; returns a random element from the array every time it's called
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

user = User.first
user.update_attributes!(
  email: 'jjw244@gmail.com',
  password: 'helloworld'
)


puts "Seed finished"
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"
