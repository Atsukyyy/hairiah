class Micropost < ApplicationRecord
  belongs_to :user
  has_many :applies
  belongs_to :prefecture, class_name: "Prefecture"
  belongs_to :area, class_name: "Area"
  has_one :post_tag, dependent: :destroy
  accepts_nested_attributes_for :post_tag
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true,
                      length: { maximum: 140 }
  validate  :picture_size

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
