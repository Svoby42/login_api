class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, uniqueness: true

  VALID_SLUG_REGEX = /\A[a-z0-9]+(?:(-|_)[a-z0-9]+)*\z/i
  validates :slug, presence: true, uniqueness: true, length: { maximum: 50 }, format: { with: VALID_SLUG_REGEX }

  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
