class Group < ApplicationRecord
  belongs_to :user
  has_many :group_entities, dependent: :destroy
  has_many :entities, through: :group_entities, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true
end
