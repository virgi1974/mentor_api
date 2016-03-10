class UserSerializer < ActiveModel::Serializer
  attributes :id,:email,:city,:cp
  
  has_many :conversations
end
