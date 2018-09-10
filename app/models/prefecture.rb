class Prefecture < ApplicationRecord
  has_many :areas, class_name: "Area", foreign_key: "prefecture_id"
  has_many :users, through: :Areas
  has_many :microposts, through: :Areas
end
