# #17  define a facotry for posts
FactoryGirl.define do
  factory :post do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    topic
    user
    rank 0.0
  end
end