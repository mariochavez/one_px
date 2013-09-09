class Photo < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true

  belongs_to :user

  scope :get_by_user, ->(user_id) { where(user_id: user_id) }

  scope :desc_id_ordered, -> { order('id desc') }

  scope :get_by_user_eager, ->(user_id) { includes(:user).get_by_user(user_id) }

  scope :get_by_id_and_user, ->(id, user_id) { where(id: id).get_by_user(user_id) }

  def as_json(options)
    super(only: [:title, :description, :id])
  end
end
