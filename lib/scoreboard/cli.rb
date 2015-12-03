require 'thor'
require_relative './team'
require_relative './football_scoreboard'

module Scoreboard
  class Cli < Thor

    no_commands do
      def initialize
        @football_scoreboard = Scoreboard::FootballScoreboard.new
      end

      def football_scoreboard
        @football_scoreboard
      end
    end

    desc "Entry point for CLI", "Pass visitor and home teams with a flag"
    def start args
      puts "Enter Home Team"
      football_scoreboard.home_team.set_name $stdin.readline.sub("\n", "")

      puts "Enter Team 2 Name"
      football_scoreboard.visitor_team.set_name $stdin.readline.sub("\n", "")
      # puts "Team 2: #{@@teams}"

      puts "We're starting the game - #{football_scoreboard.home_team.name} vs #{football_scoreboard.visitor_team.name}"
      puts ""
      puts "Record your scores! Input in the format of <team>:<score_type>"
      puts "Where <team> is h for home team, and v for visitor team"
      puts ""
      puts "Example: h:fg => home team, field goal (3 points)"
      puts "Example: v:td => visitor team, touch down (7 points)"

      puts ""
      puts "End the game with CTRL+D"

      STDIN.each_line do |str|
        input = str.sub("\n", "").split(":")
        # puts "You input: #{str} - we split to #{input}"
        team = input[0] == "h" ? football_scoreboard.home_team : football_scoreboard.visitor_team
        score_type = input[1]

        # puts "TEAM: #{team}"
        # puts "input: #{input}"

        case score_type
        when "fg"
          puts "Field Goal, #{team.name}!"
          team.field_goal
        when "td"
          puts "Touch down, #{team.name}!"
          team.touchdown
        end

        puts "Scoreboard: #{football_scoreboard.score}"
      end

      puts "The game as ended. Final scores: #{score}"
    end
  #   puts "Enter Home Team"
  #   @home_team.set_name $stdin.readline.sub("\n", "")
  #   # puts "Team 1: #{@@teams}"

  #   puts "Enter Team 2 Name"
  #   @visitor_team.set_name $stdin.readline.sub("\n", "")
  #   # puts "Team 2: #{@@teams}"

  #   puts "We're starting the game - #{home_team.name} vs #{visitor_team.name}"
  #   puts ""
  #   puts "Record your scores! Input in the format of <team>:<score_type>"
  #   puts "Where <team> is h for home team, and v for visitor team"
  #   puts ""
  #   puts "Example: h:fg => home team, field goal (3 points)"
  #   puts "Example: v:td => visitor team, touch down (7 points)"

  #   puts ""
  #   puts "End the game with CTRL+D"

  #   STDIN.each_line do |str|
  #     input = str.sub("\n", "").split(":")
  #     # puts "You input: #{str} - we split to #{input}"
  #     team = input[0] == "h" ? @home_team : @visitor_team
  #     score_type = input[1]

  #     # puts "TEAM: #{team}"
  #     # puts "input: #{input}"

  #     case score_type
  #     when "fg"
  #       puts "Field Goal, #{team.name}!"
  #       team.field_goal
  #     when "td"
  #       puts "Touch down, #{team.name}!"
  #       team.touchdown
  #     end

  #     puts "Scoreboard: #{score}"
  #   end

  #   puts "The game as ended. Final scores: #{score}"
  # end
  end
end
