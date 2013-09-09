class Api::Authorization < ActiveRecord::Base
  validates :token, :expiration, :user_id, presence: true

  belongs_to :user

  def as_json(options)
    super(only: [:token, :expiration])
  end
end
