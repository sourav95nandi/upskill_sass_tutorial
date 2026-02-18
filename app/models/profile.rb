class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, :job_title, :contact_email, :description, presence: true
end