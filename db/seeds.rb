Prefecture.create(name: '北海道')
Prefecture.create(name: '青森県')
Prefecture.create(name: '岩手県')
Prefecture.create(name: '秋田県')
Prefecture.create(name: '宮城県')
Prefecture.create(name: '山形県')
Prefecture.create(name: '福島県')
Prefecture.create(name: '茨城県')
Prefecture.create(name: '栃木県')
Prefecture.create(name: '群馬県')
Prefecture.create(name: '埼玉県')
Prefecture.create(name: '東京都')
Prefecture.create(name: '神奈川県')
Prefecture.create(name: '千葉県')
Prefecture.create(name: '山梨県')
Prefecture.create(name: '長野県')
Prefecture.create(name: '新潟県')
Prefecture.create(name: '富山県')
Prefecture.create(name: '石川県')
Prefecture.create(name: '福井県')
Prefecture.create(name: '静岡県')
Prefecture.create(name: '愛知県')
Prefecture.create(name: '岐阜県')
Prefecture.create(name: '三重県')
Prefecture.create(name: '滋賀県')
Prefecture.create(name: '京都府')
Prefecture.create(name: '大阪府')
Prefecture.create(name: '兵庫県')
Prefecture.create(name: '奈良県')
Prefecture.create(name: '和歌山県')
Prefecture.create(name: '鳥取県')
Prefecture.create(name: '島根県')
Prefecture.create(name: '岡山県')
Prefecture.create(name: '広島県')
Prefecture.create(name: '山口県')
Prefecture.create(name: '香川県')
Prefecture.create(name: '愛媛県')
Prefecture.create(name: '徳島県')
Prefecture.create(name: '高知県')
Prefecture.create(name: '福岡県')
Prefecture.create(name: '佐賀県')
Prefecture.create(name: '長崎県')
Prefecture.create(name: '熊本県')
Prefecture.create(name: '大分県')
Prefecture.create(name: '宮崎県')
Prefecture.create(name: '鹿児島県')
Prefecture.create(name: '沖縄県')

require "csv"
range = 1..47
range.each do |num|
  CSV.foreach('db/areas.csv') do |row|
    Prefecture.find(num).areas.create(name: row[num-1])
  end
end

birth = ["1992-03-15", "1994-07-23", "1995-12-30", "1998-02-02", "1991-01-14", "1993-11-11"]
password = "aaaaaa"
name = Faker::Name.name
area_pref = [[1,1], [44,3], [267,15], [435,25],[707,47]]

100.times do |n|
  num = rand(0..4)
  name = Faker::Name.name
  email = "a#{n}@a.a"
  password = "aaaaaa"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
    birth: birth[rand(1..6)],
    sex: rand(0..1),
    color: [true,false].shuffle.shift,
    hair_extension: [true,false].shuffle.shift,
    nail: [true,false].shuffle.shift,
    hair_type: rand(0..2),
    area_id: area_pref[num][0],
    prefecture_id: area_pref[num][1],
    hair_style: rand(0..4),
    use: [true,false].shuffle.shift,
    hair_permed: [true,false].shuffle.shift
  )
end

date = Date.new(2019,03,31)
15.times do |n|
  num = rand(0..4)
  name = Faker::Name.name
  email = "s#{n}@a.a"
  password = "aaaaaa"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
    birth: birth[rand(1..6)],
    sex: rand(0..1),
    area_id: area_pref[num][0],
    prefecture_id: area_pref[num][1],
    staff: true,
    qualification: date.next_year(rand(0..5))
  )
end

15.times do |n|
  num = rand(0..4)
  name = Faker::Name.name
  email = "s#{n+15}@a.a"
  password = "aaaaaa"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now,
    birth: birth[rand(1..6)],
    sex: rand(0..1),
    area_id: area_pref[num][0],
    prefecture_id: area_pref[num][1],
    staff: true,
    experience: rand(0..3)
  )
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
