module Scoreboard
  class Team
    def initialize
      @score = 0
      @name = 'NA'
    end

    def set_name name
      @name = name
    end

    def name
      @name
    end

    def score
      @score
    end

    def field_goal
      @score += 3
    end

    def touchdown
      @score += 7
    end

    def to_s
      "Team name: #{@name} - Score: #{@score}"
    end

    def inspect
      to_s
    end
  end
end
