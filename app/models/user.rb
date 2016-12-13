class User < ApplicationRecord

  has_many :posts

  before_save do
    self.email = email.downcase if email.present?
    self.role ||= :member
  end

  validates :name, length: { minimum: 1, maximum: 100}, presence: true
  validates :password, presence: true, length: {minimum: 6}, if: "password_digest.nil?"
  validates :password, length: {minimum: 6}, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 254}

  has_secure_password

  enum role: [:member, :admin]

end
