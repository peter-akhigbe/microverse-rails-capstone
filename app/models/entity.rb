class Entity < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :group_entities
  has_many :groups, through: :group_entities
end
