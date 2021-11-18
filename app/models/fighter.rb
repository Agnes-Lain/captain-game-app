class Fighter < ApplicationRecord
  validates :name, :life_points, :attack_points, presence: true
  validates :life_points, :attack_points, numericality: { only_integer: true }
  validates :life_points, inclusion: { in: 30..50 }
  validates :attack_points, inclusion: { in: 3..6 }

  def isAlive
    life_points > 0
  end
end

