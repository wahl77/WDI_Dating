class MatchesController < ApplicationController
  def show
    match = current_user.match
    redirect_to user_path(match)
  end

  def search
    results = User.better_search(params[:search], 0);
    @people = results.results
    if @people.length == 0
      flash[:notice] = "Sorry, no match found"
    end

  end
end
