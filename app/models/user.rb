class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy   

  # Message and chattin related associations
  has_many :private_messages, class_name: 'Private::Message'
  has_many  :private_conversations, 
            foreign_key: :sender_id, 
            class_name: 'Private::Conversation'
end
