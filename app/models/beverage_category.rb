class BeverageCategory < ApplicationRecord
  has_many :beverages

  validates :name, presence: true
end
