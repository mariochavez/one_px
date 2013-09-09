collection @photos, root: 'photos'

extends 'api/photos/show'

glue @authorization do
  attributes :token
end
