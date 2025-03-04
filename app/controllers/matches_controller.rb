class MatchesController < ApplicationController
    def index
        @matches = Match.includes(:user)
    end
end
