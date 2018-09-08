class Micropost < ApplicationRecord
  belongs_to :user
  has_many :applies
  belongs_to :prefecture, class_name: "Prefecture"
  belongs_to :area, class_name: "Area"
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
                      length: { maximum: 140 }
  validate  :picture_size

  enum sex: {
    女性: 0,
    男性: 1,
    男女問わず: 2
  }
  enum hair_style: {
    ベリーショート: 0,
    ショート: 1,
    ミディアム: 2,
    セミロング: 3,
    ロング: 4,
    どの髪型でも: 5
  }

  enum hair_type: {
    直毛: 0,
    ややクセ毛: 1,
    クセ毛: 2,
    どの髪質でも: 3
  }

  def created_at_to_date
    self.created_at.strftime("%Y/%m/%d")
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 1.megabytes
        errors.add(:picture, "should be less than 1MB")
      end
    end
end
