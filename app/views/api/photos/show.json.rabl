object @photo

node(:url){ |photo| api_photo_url(photo) }

attributes :title, :description, :tags

child :user do
  attributes :email
end
