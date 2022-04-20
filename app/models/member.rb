class Member < ApplicationRecord
  has_one_attached :picture

  validates :name, presence: true, uniqueness: true

end
