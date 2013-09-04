class Photo < ActiveRecord::Base
  validates :title, :description, presence: true
end
