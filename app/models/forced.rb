class Forced < ApplicationRecord
  validates :value, presence: true
  validates :dt, presence: true
end
