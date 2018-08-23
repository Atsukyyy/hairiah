class Prefecture < ApplicationRecord
  belongs_to :region, class_name: "Region"

  has_many :areas, class_name: "Area", foreign_key: "prefecture_id"
  has_many :users, through: :Areas
end
