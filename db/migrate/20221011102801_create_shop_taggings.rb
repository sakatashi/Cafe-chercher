class CreateShopTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_taggings do |t|
      t.references  :post, null: false, foreign_key: true
      t.references  :shop_tag, null: false, foreign_key: true
      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようにする
    add_index :post_tags, [:post_id, :shop_tag_id], unique: true
  end
end
