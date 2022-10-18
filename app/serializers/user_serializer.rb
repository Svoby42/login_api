class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :name, :email, :role
  has_many :posts
end
