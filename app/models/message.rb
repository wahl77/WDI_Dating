class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  attr_accessible :content, :receiver, :receiver_id, :sender, :sender_id
end
