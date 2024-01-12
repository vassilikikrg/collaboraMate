class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category
  end
  class User < ApplicationRecord
    ...
    has_many :posts, dependent: :destroy       
  end
  
  class Category < ApplicationRecord
    has_many :posts
  end