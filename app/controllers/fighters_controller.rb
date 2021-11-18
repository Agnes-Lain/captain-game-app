class FightersController < ApplicationController
  before_action :set_fighter, only: [:show, :edit, :update, :destroy]

  def index
    @fighters = Fighter.all
    if params[:combat]
      @player1 = Fighter.find(params[:combat][:p1_id])
      @player2 = Fighter.find(params[:combat][:p2_id])
      fight(@player1, @player2)
    end
  end

  def show
  end

  def new
    @fighter = Fighter.new
  end

  def create
    @fighter = Fighter.new(fighter_params)
    # give a random life points between 30 to 50
    @fighter.life_points = rand(30..50)
    # for balance the fighter, the attack points decrease when lift points increase
    @fighter.attack_points = ((60 - @fighter.life_points) / 5 ).round
    @fighter.save
    if @fighter.save
      redirect_to fighter_path(@fighter)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @fighter.update(fighter_params)
    redirect_to fighter_path(@fighter)
  end

  def destroy
    @fighter.destroy
    redirect_to fighters_path
  end

  private

  def fighter_params
    params.require(:fighter).permit(:name)
  end

  def set_fighter
    @fighter = Fighter.find(params[:id])
  end

  def set_combat(p1_id, p2_id)

    return @player1, @player
  end

  def fight(player1, player2)
    while playter1.isAlive && player2.isAlive
      player1.hit(player2)
      player2.hit(player1)
      #send to front the result at the end of each round
    end

    if player1.isAlive
      @winner = Combat.create!(fighter_id:playter1.id, adversary_id:player2.id, result: 1)
      @looser = Combat.create!(fighter_id:playter2.id, adversary_id:player1.id, result: -1)
    elsif p2.isAlive
      @looser = Combat.create!(fighter_id:playter1.id, adversary_id:player2.id, result: -1)
      @winner = Combat.create!(fighter_id:playter2.id, adversary_id:player1.id, result: 1)
    else
      @equaler = Combat.create!(fighter_id:playter1.id, adversary_id:player2.id, result: 0)
      Combat.create!(fighter_id:playter2.id, adversary_id:player1.id, result: 0)
    end
  end

end
