class Contact < ApplicationRecord
    belongs_to :user
    belongs_to :contact, class_name: "User"
  
    validates_uniqueness_of :user_id, scope: :contact_id
  
    def self.find_by_users(user_id, contact_id)
      where('user_id = ? AND contact_id = ?', user_id, contact_id).or(
             where('user_id = ? AND contact_id = ?', contact_id, user_id)
           )[0]
    end
end