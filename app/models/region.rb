class Region < ApplicationRecord
  has_many :prefectures, class_name: "Prefecture", foreign_key: "region_id"
end
