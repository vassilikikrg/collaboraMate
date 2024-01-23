class Post < ApplicationRecord
    # Associations
    belongs_to :user
    belongs_to :category
    default_scope -> { includes(:user).order(created_at: :desc) }

    # Scopes
    # Retrieves posts by a given branch and category_name by performing a join with the Category model.
    scope :by_category, -> (branch, category_name) do 
      joins(:category).where(categories: {name: category_name, branch: branch}) 
    end
    # Retrieves posts by a given branch by joining with the Category model.
    scope :by_branch, -> (branch) do
      joins(:category).where(categories: {branch: branch}) 
    end
    # Performs a case-insensitive search in the title and content columns based on a provided search term.
    scope :search, -> (search) do
      where("title ILIKE lower(?) OR content ILIKE lower(?)", "%#{search}%", "%#{search}%")
    end

    # Validations
    validates :title, presence: true, length: { minimum: 5, maximum: 255 }
    validates :content, presence: true, length: { minimum: 20, maximum: 1000 }
    validates :category_id, presence: true
  end
