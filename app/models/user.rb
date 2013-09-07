class User < ActiveRecord::Base
  has_secure_password validations: true

  validates :email, presence: true, uniqueness: true

  has_many :photos
end
