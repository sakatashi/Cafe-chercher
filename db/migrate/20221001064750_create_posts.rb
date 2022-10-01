class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
       t.text  :content
      t.string :shop_name
      t.string :shop_place
      t.string :shop_holiday
      t.string :shop_price
      t.integer :is_draft,default: 0,null: false
      t.timestamps
    end
  end
end
