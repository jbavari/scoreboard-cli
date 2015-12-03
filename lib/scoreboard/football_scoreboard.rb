module Scoreboard
  class FootballScoreboard

    def initialize
      @home_team = Team.new
      @visitor_team = Team.new
    end

    def teams
      { :home_team => @home_team, :visitor_team => @visitor_team }
    end

    def home_team
      @home_team
    end

    def visitor_team
      @visitor_team
    end

    def score
      "#{home_team.name} - #{home_team.score}, #{visitor_team.name} - #{visitor_team.score}"
    end
  end
end
