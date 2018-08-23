Region.create(name: '北海道地方')
Region.create(name: '東北地方')
Region.create(name: '関東地方')
Region.create(name: '中部地方')
Region.create(name: '近畿地方')
Region.create(name: '中国地方')
Region.create(name: '四国地方')
Region.create(name: '九州・沖縄地方')

Region.find(1).prefectures.create(name: '北海道')
Region.find(2).prefectures.create(name: '青森県')
Region.find(2).prefectures.create(name: '岩手県')
Region.find(2).prefectures.create(name: '秋田県')
Region.find(2).prefectures.create(name: '宮城県')
Region.find(2).prefectures.create(name: '山形県')
Region.find(2).prefectures.create(name: '福島県')
Region.find(3).prefectures.create(name: '茨城県')
Region.find(3).prefectures.create(name: '栃木県')
Region.find(3).prefectures.create(name: '群馬県')
Region.find(3).prefectures.create(name: '埼玉県')
Region.find(3).prefectures.create(name: '東京都')
Region.find(3).prefectures.create(name: '神奈川県')
Region.find(3).prefectures.create(name: '千葉県')
Region.find(4).prefectures.create(name: '山梨県')
Region.find(4).prefectures.create(name: '長野県')
Region.find(4).prefectures.create(name: '新潟県')
Region.find(4).prefectures.create(name: '富山県')
Region.find(4).prefectures.create(name: '石川県')
Region.find(4).prefectures.create(name: '福井県')
Region.find(4).prefectures.create(name: '静岡県')
Region.find(4).prefectures.create(name: '愛知県')
Region.find(4).prefectures.create(name: '岐阜県')
Region.find(4).prefectures.create(name: '三重県')
Region.find(5).prefectures.create(name: '滋賀県')
Region.find(5).prefectures.create(name: '京都府')
Region.find(5).prefectures.create(name: '大阪府')
Region.find(5).prefectures.create(name: '兵庫県')
Region.find(5).prefectures.create(name: '奈良県')
Region.find(5).prefectures.create(name: '和歌山県')
Region.find(6).prefectures.create(name: '鳥取県')
Region.find(6).prefectures.create(name: '島根県')
Region.find(6).prefectures.create(name: '岡山県')
Region.find(6).prefectures.create(name: '広島県')
Region.find(6).prefectures.create(name: '山口県')
Region.find(7).prefectures.create(name: '香川県')
Region.find(7).prefectures.create(name: '愛媛県')
Region.find(7).prefectures.create(name: '徳島県')
Region.find(7).prefectures.create(name: '高知県')
Region.find(8).prefectures.create(name: '福岡県')
Region.find(8).prefectures.create(name: '佐賀県')
Region.find(8).prefectures.create(name: '長崎県')
Region.find(8).prefectures.create(name: '熊本県')
Region.find(8).prefectures.create(name: '大分県')
Region.find(8).prefectures.create(name: '宮崎県')
Region.find(8).prefectures.create(name: '鹿児島県')
Region.find(8).prefectures.create(name: '沖縄県')

require "csv"
range = 1..47
range.each do |num|
  CSV.foreach('db/areas.csv') do |row|
    Prefecture.find(num).areas.create(name: row[num-1])
  end
end

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             prefecture_id: 1,
             area_id: 1)

birth = ["1992-03-15", "1994-07-23", "1995-12-30", "1998-02-02", "1991-01-14", "1993-11-11"]
password = "aaaaaa"
name = Faker::Name.name

20.times do |n|
  name     = Faker::Name.name
  email    = "a#{n}@a.a"
  password = "aaaaaa"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               birth: birth[rand(1..6)],
               sex: rand(0..1),
               color: [true,false].shuffle.shift,
               hair_extension: [true,false].shuffle.shift,
               nail: [true,false].shuffle.shift,
               reason: rand(0..1),
               hair_type: rand(0..2),
               area_id: 1,
               prefecture_id: 1,
               hair_style: rand(0..4))
end

20.times do |n|
  name     = Faker::Name.name
  email    = "a#{n+20}@a.a"
  password = "aaaaaa"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               birth: birth[rand(1..6)],
               sex: rand(0..1),
               color: [true,false].shuffle.shift,
               hair_extension: [true,false].shuffle.shift,
               nail: [true,false].shuffle.shift,
               reason: rand(0..1),
               hair_type: rand(0..2),
               area_id: 44,
               prefecture_id: 3,
               hair_style: rand(0..4))
end

20.times do |n|
  name     = Faker::Name.name
  email    = "a#{n+40}@a.a"
  password = "aaaaaa"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               birth: birth[rand(1..6)],
               sex: rand(0..1),
               color: [true,false].shuffle.shift,
               hair_extension: [true,false].shuffle.shift,
               nail: [true,false].shuffle.shift,
               reason: rand(0..1),
               hair_type: rand(0..2),
               area_id: 267,
               prefecture_id: 15,
               hair_style: rand(0..4))
end

20.times do |n|
  name     = Faker::Name.name
  email    = "a#{n+60}@a.a"
  password = "aaaaaa"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               birth: birth[rand(1..6)],
               sex: rand(0..1),
               color: [true,false].shuffle.shift,
               hair_extension: [true,false].shuffle.shift,
               nail: [true,false].shuffle.shift,
               reason: rand(0..1),
               hair_type: rand(0..2),
               area_id: 435,
               prefecture_id: 25,
               hair_style: rand(0..4))
end

20.times do |n|
  name     = Faker::Name.name
  email    = "a#{n+80}@a.a"
  password = "aaaaaa"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               birth: birth[rand(1..6)],
               sex: rand(0..1),
               color: [true,false].shuffle.shift,
               hair_extension: [true,false].shuffle.shift,
               nail: [true,false].shuffle.shift,
               reason: rand(0..1),
               hair_type: rand(0..2),
               area_id: 707,
               prefecture_id: 47,
               hair_style: rand(0..4))
end

20.times do |n|
  name     = Faker::Name.name
  email    = "s#{n}@a.a"
  password = "aaaaaa"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               birth: birth[rand(1..6)],
               sex: rand(0..1),
               area_id: 707,
               prefecture_id: 47,
               staff: true)
end
#
# users = User.order(:created_at).take(6)
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.microposts.create!(content: content) }
# end
#
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }
