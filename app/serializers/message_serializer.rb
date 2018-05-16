class MessageSerializer < ActiveModel::Serializer
  attributes :id, :sent_by, :content
end
