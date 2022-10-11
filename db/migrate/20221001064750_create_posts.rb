class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id,null: false
      t.string :title,null: false
       t.text  :content,null: false
      t.string :shop_name
      t.string :shop_place
      t.string :shop_holiday
      t.integer :shop_price,default: 0,null: false
      t.integer :is_draft,default: 0,null: false
      t.timestamps
    end
  end
end
