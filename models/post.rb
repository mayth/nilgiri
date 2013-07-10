class Post
  include Mongoid::Document

  field :title, type: String
  field :body, type: String
  field :posted_at, type: DateTime
  field :updated_at, type: DateTime
end
