object @photo

node(:url){ |photo| api_photo_url(photo) }

attributes :title, :description, :tags

node(:image){ |photo| photo.image.url }

child :user do
  attributes :email
end
