class MatchesController < ApplicationController
  def show
    match = current_user.match
    redirect_to user_path(match)
  end
end
