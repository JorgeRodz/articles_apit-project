class Article < ApplicationRecord
  validates :title, :content, :slug, presence: true
  validates :slug, uniqueness: true

  # To make queries to the DB
  scope :recent, -> { order(created_at: :desc) } # Retrieve Recent articles first
end