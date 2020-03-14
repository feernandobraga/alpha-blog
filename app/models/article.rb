class Article < ApplicationRecord

  belongs_to :user # it means that any article belongs to a single user
                   # and therefore it's the many side of the relationship

  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 5}
  validates :user_id, presence: true

end