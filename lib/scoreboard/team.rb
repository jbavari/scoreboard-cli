module Scoreboard
  class Team
    attr_reader :name, :score
    attr_writer :name, :score
    def initialize
      @score = 0
      @name = "NA"
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
