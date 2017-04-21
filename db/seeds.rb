require 'random_data'

# Create Posts
 50.times do
 # #1  Adding a ! instructs the method to raise an error if there's a problem with the data we're seeding
   Post.create!(
 # #2  class RandomData attributes DNE yet -> "Whishful Coding" can increase productivity becasue it allows you to stay focused on one problem at a time
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

 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
