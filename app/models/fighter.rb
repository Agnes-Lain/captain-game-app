class Fighter < ApplicationRecord
  has_many :combats
  validates :name, :life_points, :attack_points, presence: true
  validates :life_points, :attack_points, numericality: { only_integer: true }
  validates :life_points, inclusion: { in: 30..50 }
  validates :attack_points, inclusion: { in: 2..6 }

  def isAlive?
    life_points > 0
  end

  def hit(enimy)
    enimy.life_points -= one_attack_point
  end

  def fighter_info
    "#{name} - Life: #{life_points} / Attack: #{attack_points}"
  end

  def one_attack_point
    rand(0..self.attack_points)
  end

end

