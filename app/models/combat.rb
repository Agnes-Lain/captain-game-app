class Combat < ApplicationRecord
  belongs_to :fighter
  validates :fighter_id, :adversary_id, :result, presence: true
  validates :fighter_id, :adversary_id, :result, numericality: { only_integer: true }
  validates :result, inclusion: { in: -1..1 }
end
