class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, :job_title, :contact_email, :description, presence: true
  has_one_attached :avatar
  validate :avatar_validation

  private

  def avatar_validation
    return unless avatar.attached?

    unless avatar.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:avatar, 'must be a PNG, JPG, or JPEG')
    end

    if avatar.byte_size > 5.megabytes
      errors.add(:avatar, 'is too large. Maximum size is 5MB.')
    end
  end
end