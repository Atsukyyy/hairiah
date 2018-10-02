module SoftDeletable
  extend ActiveSupport::Concern

  included do
    scope :deleted, -> { where.not(deleted_at: nil) }
    scope :undeleted, -> { where(deleted_at: nil) }
  end

  module ClassMethods
  end

  def soft_delete!
    self.deleted_at = Time.now
    save!
  end

  def restore!
    self.deleted_at = nil
    save!
  end

  def soft_deleted?
    deleted_at.present?
  end
end
