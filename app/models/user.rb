class User < ApplicationRecord

  has_many :articles #indicates that one user can have many articles

  before_save { self.email = email.downcase }

  validates :username, presence: true,
            uniqueness: {case_sensitive: false}, #username needs to be unique regardless of capital letters
            length: {minimum: 3, maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #contain the regular expression to validate emails

  validates :email, presence: true,
            length: {maximum: 150},
            uniqueness: {case_sensitive: false},
            format: {with: VALID_EMAIL_REGEX } #VALID_EMAIL_REGEX works as a "variable"

end
