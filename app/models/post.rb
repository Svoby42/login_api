class Post < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { minimum: 10 }
end
