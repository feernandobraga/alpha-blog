class Article < ApplicationRecord

  belongs_to :user # it means that any article belongs to a single user

  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 5}

end