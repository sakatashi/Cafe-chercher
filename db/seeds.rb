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
#ユーザの作成
users = User.create!(
  [
    { email: "piyo@test.com",
      name: "ぴよ",
      password: "password",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"),
      filename: "sample-user1.jpg"),
      introduction: "はじめまして！🐤\r\nよろしくお願いします。"},

    { email: "koguma@test.com",
      name: "こぐま",
      password: "password",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"),
      filename: "sample-user2.jpg"),
      introduction: "はじめまして！🍠\r\nカフェ巡りが好きです。\r\n東京周辺のカフェ投稿します！" },

    { email: "rabi@test.com",
      name: "rabi",
      password: "password",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"),
      filename: "sample-user3.jpg"),
      introduction: "はじめまして！🐰\r\n仲良くしてください。"}
  ]
)

#投稿の作成
Post.create!(
  [
    # ユーザ1の投稿
    { title: "隠れ家カフェ",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.JPG"),
      filename: "sample-post1.jpg"),
      content: "辿り着くまで少し迷いました！笑\r\n\r\nアイスのウィンナーコーヒーとテリーヌショコラを注文！\r\n\r\n手書きのメニューや店内が独特な世界観でした！\r\n\r\n#cafe#広島カフェ#尾道カフェ#おしゃれカフェ",
      user_id: users[0].id,
      shop_name: "satie coffe",
      shop_place: "尾道駅",
      shop_holiday: "不定休",
      shop_price: "1000~1999",
      is_draft: 1,
      lat: "34.4069763",
      lng: "133.1975454" },

    # ユーザ2の投稿
    { title: "老舗の喫茶店発見！",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.JPG"),
      filename: "sample-post2.jpg"),
      content: "地下を下ると洞窟のような空間がありました！\r\n\r\n人気のお店で少し並びました！\r\n店内の雰囲気が良く、\r\nレアチーズケーキ美味 しかったです！\r\n\r\n#東京カフェ#吉祥寺カフェ#洞窟#喫茶店",
      user_id: users[1].id,
      shop_name: "COFFEE HALL くぐつ草",
      shop_place: "吉祥寺駅から徒歩３分",
      shop_holiday: "無休",
      shop_price: "1000~1999",
      is_draft: 1,
      lat: "35.7041899",
      lng: "139.5782272" },

    # ユーザ3の投稿
    { title: "自然を感じられる！",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.JPG"),
      filename: "sample-post3.jpg"),
      content: "森に囲まれたところにありました。\r\n\r\n木の温もりを感じる素敵な店内！\r\n\r\nベイクドチーズケーキとハーブティーを注文しました 。\r\nランチも美味しそうだったのでまた行きたい！\r\n#埼玉カフェ#越生カフェ#自然#素敵な店内",
      user_id: users[2].id,
      shop_name: "オクムサ・マルシェ",
      shop_place: "越生駅からバス",
      shop_holiday: "木・金・土",
      shop_price: "1000~1999",
      is_draft: 1,
      lat: "35.9646409",
      lng: "139.262682" },

    # ユーザ1の非公開投稿
    { title: "おしゃれな韓国カフェ",
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.JPG"),
      filename: "sample-post3.jpg"),
      shop_name: "CAFE Neul(カフェ ヌル）",
      content: "韓国カフェ",
      user_id: users[0].id,
      is_draft: 0
    }
  ]
)

#こだわりタグ作成
ShopTag.create([                #ID
  { name: "落ち着いた空間" },   #1
  { name: " インスタ映え" },    #2
  { name: "Wi-Fi" },            #3
  { name: "電源あり" },         #4
  { name: "キャッシュレス可" }, #5
  { name: "テイクアウト" },     #6
  { name: "コンセント" },       #7
  { name: "ペット可" },         #8
  { name: "30席以上" },         #9
  { name: "駐車場あり" },       #10
  { name: "1人カフェ" },        #11
  { name: "夜21時以降" }        #12
])

# 投稿とこだわりタグの紐づけ
ShopTagging.create!(
  [
    # 投稿1のタグ付け
    # （落ち着いた空間・インスタ映え）
    { post_id: 1,
      shop_tag_id: 1
    },
    { post_id: 1,
      shop_tag_id: 2
    },
    # 投稿2のタグ付け
    # （落ち着いた空間・テイクアウト・30席以上）
    { post_id: 2,
      shop_tag_id: 1
    },
    { post_id: 2,
      shop_tag_id: 6
    },
    { post_id: 2,
      shop_tag_id: 9
    },
    # 投稿3のタグ付け
    # （落ち着いた空間・キャッシュレス可・駐車場あり）
    { post_id: 3,
     shop_tag_id: 1
    },
    { post_id: 3,
      shop_tag_id: 5
    },
    { post_id: 3,
      shop_tag_id: 10
    }
  ]
)

# フォローフォロワーの作成
Relationship.create!(
  [
    { follower_id: 1,
      followed_id: 2
    },
    { follower_id: 2,
      followed_id: 1
    },
    { follower_id: 2,
      followed_id: 3
    },
    { follower_id: 3,
      followed_id: 1
    }
  ]
)

# お気に入りの作成
Like.create!(
  [
    { user_id: 2,
      post_id: 1
    },
    { user_id: 3,
      post_id: 1
    },
    { user_id: 2,
      post_id: 3
    },
    { user_id: 1,
      post_id: 3
    }
  ]
)

# コメントの作成
Comment.create!(
  [
    { user_id: 1,
      post_id: 3,
      comment: "チーズケーキ美味しそうですね！😀",
        score: 0.9e0
    },
    { user_id: 2,
      post_id: 1,
      comment: "おしゃれですね！今度、尾道に行くので行ってみます👍",
        score: 0.9e0 
    }
  ]
)

# ユーザ1と2のチャットルーム作成
Room.create!()

UserRoom.create!(
  [
    { user_id: 1,
      room_id: 1
    },
    { user_id: 2,
      room_id: 1
    }
  ]
)

# ユーザ1と2のチャット
Chat.create!(
  [
    { user_id: 2,
      room_id: 1,
      message: "ぴよさん、はじめまして！フォローありがとうございます😆よろしくお願いします！"
    },
    { user_id: 1,
      room_id: 1,
      message: "こぐまさん、はじめまして！メッセージありがとうございます😆よろしくお願いします！"
    }
  ]
)

#通知
Notification.create!(
  [
    { visitor_id: 2,
      visited_id: 1,
      post_id: 1,
      action: "like",
      checked: false,
    }
  ]
)