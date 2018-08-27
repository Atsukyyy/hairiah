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

  enum reason: {
    練習: 0,
    練習兼サロンモデル募集: 1
  }
  enum color: {
    希望: true,
    なし: false
  }, _suffix: true
  enum hair_extension: {
    希望: true,
    なし: false
  }, _suffix: true
  enum mens: {
    希望: true,
    なし: false
  }, _suffix: true

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
