class FightersController < ApplicationController
  before_action :set_fighter, only: [:show, :edit, :update, :destroy]

  def index
    @fighters = Fighter.all
    # Parameters: {"player1"=>"", "equipment1"=>"knif", "player2"=>"", "equipment2"=>"sword", "commit"=>"FIGHT!!"}
    if params[:player1] && params[:player1]!=""
      @player1 = Fighter.find(params[:player1].split(" ")[0].to_i)
      @player2 = Fighter.find(params[:player2].split(" ")[0].to_i)
      p1_equip = Equipment.where(name: params["equipment1"])[0]
      p2_equip = Equipment.where(name: params["equipment2"])[0]
      @player1.life_points += p1_equip.protect
      @player1.attack_points += p1_equip.attack
      @player2.life_points += p2_equip.protect
      @player2.attack_points += p2_equip.attack
      fight(@player1, @player2)
    end
    @equipments = Equipment.all
  end

  def show
    @wins = Combat.where(fighter_id: @fighter.id, result: 1).count
    @fails = Combat.where(fighter_id: @fighter.id, result: -1).count
    @ties = Combat.where(fighter_id: @fighter.id, result: 0).count
    @total = @wins + @fails + @ties
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
      save_combat(player1, player2, 1, -1)
      @winner = player1
      @loser = player2
    elsif player2.isAlive?
      save_combat(player2, player1, 1, -1)
      @loser = player1
      @winner = player2
    else
      save_combat(player1, player2, 0, 0)
      @equaler = player1
    end
  end

  def save_combat(winner, loser, score_win, score_lose)
    Combat.create!(fighter_id: winner.id, adversary_id: loser.id, result: score_win)
    Combat.create!(fighter_id: loser.id, adversary_id: winner.id, result: score_lose)
  end
end
