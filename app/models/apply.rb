class Apply < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  validates :user_id, uniqueness: true

  def created_at_to_date
    self.created_at.strftime("%Y/%m/%d")
  end
end
