class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :groups, dependent: :destroy
  has_many :entities, foreign_key: :author_id, dependent: :destroy

  validates :name, presence: true, length: { within: 4..250 }
  validates :email, presence: true
  validates :password, presence: true
end
