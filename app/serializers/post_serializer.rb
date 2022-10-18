class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :user_id, :content
  belongs_to :user
end
