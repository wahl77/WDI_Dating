class PokesController < ApplicationController
  def new
  end

  def create
    @poke = Poke.new
    @poke.poker = current_user 
    @poke.pokee = User.find(params[:id])
    @poke.save
    redirect_to user_path(@poke.pokee)
  end

  def update
    @poke = Poke.find(params[:id])
    @poke.viewed = true
    redirect_to user_path(current_user)
  end

  def poke_back
    @poke = Poke.new
    @poke.poker = current_user 
    @poke.pokee = User.find(params[:id])
    @poke.save
    old_pock = current_user.new_pokes.where("poker_id = ?", @poke.pokee.id).each{|poke|
      poke.update_attributes(:viewed => true)
    }
    redirect_to user_path(current_user)
  end
end
