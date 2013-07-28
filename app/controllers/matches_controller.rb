class MatchesController < ApplicationController
  def show
    match = current_user.match
    redirect_to user_path(match)
  end

  def search
    results = User.better_search(params[:search], current_user.interested_in_male);
    person = results.results.first 
    if person
      redirect_to user_path(person)
    else
      redirect_to root_path
    end

  end
end
