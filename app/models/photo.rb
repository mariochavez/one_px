class Photo < ActiveRecord::Base
  validates :title, :description, presence: true

  def as_json(options)
    super(only: [:title, :description, :id], methods: [:calculate])
  end

  def calculate
    'test'
  end
end
