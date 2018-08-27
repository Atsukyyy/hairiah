class User < ApplicationRecord
  has_many :from_messages, class_name: "Message",
          foreign_key: "from_id", dependent: :destroy
  has_many :to_messages, class_name: "Message",
            foreign_key: "to_id", dependent: :destroy
  has_many :sent_messages, through: :from_messages, source: :from
  has_many :received_messages, through: :to_messages, source: :to

  # Send message to other user
  def send_message(other_user, room_id, content)
    from_messages.create!(to_id: other_user.id, room_id: room_id, content: content)
  end

  has_many :microposts, dependent: :destroy
  has_many :active_relationships,
        class_name: 'Relationship',
       foreign_key: :follower_id,
         dependent: :destroy
  has_many :passive_relationships,
        class_name: 'Relationship',
       foreign_key: :followed_id,
         dependent: :destroy
  # @user.active_relationships.map(&:followed)
  # @user.following
  has_many :following,
    through: 'active_relationships',
     source: 'followed'
  has_many :followers,
    through: 'passive_relationships',
     source: 'follower'

  belongs_to :prefecture, class_name: "Prefecture"
  belongs_to :area, class_name: "Area"

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  has_many :thumbnails
  accepts_nested_attributes_for :thumbnails
  # mount_uploader :thumbnail, ThumbnailUploader
  # serialize :avatars, JSON # If you use SQLite, add this line.


  validates :name,  presence: true, length: { maximum:  50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true,
    length: { minimum: 6 }, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest,
      User.digest(remember_token))
  end

  def forget
    self.update_attribute(:remember_digest, nil)
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # 試作feedの定義
  # 完全な実装は次章の「ユーザーをフォローする」を参照
  # current_user.feed
  # current_user.id
  # current_user.microposts
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id",
                                 user_id: self.id)
  end

  def follow(other_user)
    self.active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    self.following.include?(other_user)
  end

  enum sex: {
    女性: 0,
    男性: 1
  }
  enum hair_style: {
    ベリーショート: 0,
    ショート: 1,
    ミディアム: 2,
    セミロング: 3,
    ロング: 4
  }

  enum hair_type: {
    直毛: 0,
    ややクセ毛: 1,
    強いクセ毛: 2
  }

  enum reason: {
    単なる節約のため: 0,
    モデルを目指しているため: 1
  }
  enum color: {
    可能: true,
    不可能: false
  }, _suffix: true

  enum hair_extension: {
    可能: true,
    不可能: false
  }, _suffix: true

  enum nail: {
    希望: true,
    希望しない: false
  }

  # ユーザー名による絞り込み
  scope :get_by_name, ->(name) {
    where("name like ?", "%#{name}%")
  }
  # 年齢による絞り込み
  scope :get_by_age, ->(age_from, age_to) {
    where(age: age_from..age_to)
  }
  # 性別による絞り込み
  scope :get_by_sex, ->(sex) {
    where(sex: sex)
  }
  # 都道府県による絞り込み
  scope :get_by_prefecture_id, ->(prefecture_id) {
    where(prefecture_id: prefecture_id)
  }
  # 市町村区による絞り込み
  scope :get_by_area_id, ->(area_id) {
    where(area_id: area_id)
  }
  # カラーによる絞り込み
  scope :get_by_color, ->(color) {
    where(color: color)
  }
  # エクステによる絞り込み
  scope :get_by_hair_extension, ->(hair_extension) {
    where(hair_extension: hair_extension)
  }
  # ネイルによる絞り込み
  scope :get_by_nail, ->(nail) {
    where(nail: nail)
  }
  # 理由による絞り込み
  scope :get_by_advertisement, ->(advertisement) {
    where(advertisement: advertisement)
  }

  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birth.strftime(date_format).to_i) / 10000
  end

  def created_at_to_date
    self.created_at.strftime("%Y/%m/%d")
  end

  private

    def downcase_email
      self.email = self.email.downcase
    end

    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(self.activation_token)
      # @user.activation_digest => ハッシュ値
    end

end
