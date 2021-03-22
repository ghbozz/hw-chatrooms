class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user

  validates :content, presence: true

  # after_create_commit { broadcast_append_to "chatroom_#{chatroom.id}", partial: "chatrooms/message" }

  after_create_commit  -> {
    User.all.each do |user|
      broadcast_append_to "chatroom_#{chatroom.id}_user_#{user.id}", 
      partial: "chatrooms/message",
      locals: { me: self.user.id == user.id ? true : false }
    end
  }


  after_create_commit { 
    broadcast_replace_to "chatrooms_list", 
    partial: "chatrooms/btn", 
    locals: { chatroom: self.chatroom, new_message: true },
    target: "chatroom_#{self.chatroom.id}_btn"
  }
  
  after_destroy_commit { broadcast_remove_to "messages" }
end
