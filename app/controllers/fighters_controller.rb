class FightersController < ApplicationController
  before_action :set_fighter, only: [:show, :edit, :update, :destroy]
  def index
    @fighters = Fighter.all
  end

  def show
  end

  def new
    @fighter = Fighter.new
  end

  def create
    @fighter = Fighter.new(fighter_params)
    @fighter.life_points = rand(30..50)
    @fighter.attack_points = ((60 - @fighter.life_points) / 5 ).ceil
    @fighter.save
    if @fighter.save
      redirect_to fighters_path
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
end
