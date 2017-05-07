class AddTopicToPosts < ActiveRecord::Migration
  def change
# #5 see that the name we gave the migration, AddTopicToPosts, is very important
    add_column :posts, :topic_id, :integer
# #6  created an index on topic_id with the generator.  An index improves the speed of operations on a db table
    add_index :posts, :topic_id
  end
end
