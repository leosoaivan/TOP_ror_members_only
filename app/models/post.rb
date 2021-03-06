class Post < ApplicationRecord
  belongs_to :user

  validates :text, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
end
