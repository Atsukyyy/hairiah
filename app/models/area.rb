class Area < ApplicationRecord
  belongs_to :prefecture, class_name: "Prefecture"
  has_many :users, class_name: "User", foreign_key: "area_id"
  has_many :microposts, class_name: "Micropost", foreign_key: "area_id"

  validates :name, uniqueness: true
end
