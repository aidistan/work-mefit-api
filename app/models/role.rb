class Role < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_roles

  validates :name, uniqueness: true, presence: true
end
