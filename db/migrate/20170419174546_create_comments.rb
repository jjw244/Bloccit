class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
  # #3  the index on the references line tells the db to index the post_id column (efficiency) ->
    #   good for foreign keys and is generate automatically when using the "references" arugment
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
