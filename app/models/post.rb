class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :body, presence: true
  validates :slug, presence: true, uniqueness: true,
    format: { with: /\A[0-9a-zA-Z_-]+\z/ }

  def slug_candidate
    s = title.presence || ''
    s.parameterize
  end
end
