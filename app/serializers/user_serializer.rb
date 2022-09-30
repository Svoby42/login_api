class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :name, :email, :role, :created_at, :updated_at
end
