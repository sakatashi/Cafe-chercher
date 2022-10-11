# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者の作成
Admin.create!(
  email: "admin@com",
  password: "admincafe"
)

ShopTag.create([
  { name: "落ち着いた空間" },
  { name: " インスタ映え" },
  { name: "Wi-Fi" },
  { name: "電源あり" },
  { name: "キャッシュレス可" },
  { name: "テイクアウト" },
  { name: "コンセント" },
  { name: "ペット可" }
])