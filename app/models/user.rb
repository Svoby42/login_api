class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :full_name, presence: true, length: { maximum: 60 }
  validates :name,      presence: true, length: { maximum: 50 },
            uniqueness: true
  validates :email,     presence: true, length: { maximum: 255 },
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password,  presence: true, length: { minimum: 6 }
end
