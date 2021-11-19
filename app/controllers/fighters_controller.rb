class FightersController < ApplicationController
  before_action :set_fighter, only: [:show, :edit, :update, :destroy]

  def index
    @fighters = Fighter.all
    # Parameters: {"player1"=>"1 - Ed", "player2"=>"7 - Cammy", "commit"=>"FIGHT!!"}
    if params[:player1]
      @player1 = Fighter.find(params[:player1][0].to_i)
      @player2 = Fighter.find(params[:player2][0].to_i)
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
    params.require(:fighter).permit(:name, :img_url)
  end

  def set_fighter
    @fighter = Fighter.find(params[:id])
  end

  def set_combat(p1_id, p2_id)

    return @player1, @player
  end

  def fight(player1, player2)
    round = 0
    while player1.isAlive? && player2.isAlive?
      player1.hit(player2)
      player2.hit(player1)
      #send to front the result at the end of each round
      # respond_to do |format|
      #   format.html { render }
      #   format.json {
      #     render json: {
      #       p1_status: player1.fighter_info,
      #       pl_attack: player1.one_attack_point,
      #       p2_status: player2.fighter_info,
      #       p2_attack: player2.one_attack_point,
      #      }
      #   }
      # end
    end

    if player1.isAlive?
      winner_record = Combat.create!(fighter_id:player1.id, adversary_id:player2.id, result: 1)
      @winner = player1
      looser_record = Combat.create!(fighter_id:player2.id, adversary_id:player1.id, result: -1)
      @looser = player2
    elsif player2.isAlive?
      looser_record = Combat.create!(fighter_id:player1.id, adversary_id:player2.id, result: -1)
      @looser = player1
      winner_record = Combat.create!(fighter_id:player2.id, adversary_id:player1.id, result: 1)
      @winner = player2
    else
      equaler_record = Combat.create!(fighter_id:player1.id, adversary_id:player2.id, result: 0)
      Combat.create!(fighter_id:player2.id, adversary_id:player1.id, result: 0)
      @equaler = player1
    end
  end

end
