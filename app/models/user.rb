class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation {email.downcase!}
  has_secure_password
  validates :password, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  def last_one_admin?
    User.where(admin: true).count==1 && self.admin==true
  end
end
