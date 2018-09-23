class Apply < ApplicationRecord
  belongs_to :micropost
  belongs_to :user
  
  def created_at_to_date
    self.created_at.strftime("%Y/%m/%d")
  end
end
