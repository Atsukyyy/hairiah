class Thumbnail < ApplicationRecord
  belongs_to :user
  # mount_uploader :image, ThumbnailUploader
  mount_uploader :image, ThumbnailUploader
end
