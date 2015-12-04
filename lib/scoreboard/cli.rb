require "thor"
require_relative "./team"
require_relative "./football_scoreboard"

module Scoreboard
  class Cli < Thor
    no_commands do
      attr_reader :football_scoreboard
      def initialize
        @football_scoreboard = Scoreboard::FootballScoreboard.new
      end

      def print_initial_output
        puts "We're starting the game - #{football_scoreboard.home_team.name} vs #{football_scoreboard.visitor_team.name}"
        puts ""
        puts "Record your scores! Input in the format of <team>:<score_type>"
        puts "Where <team> is h for home team, and v for visitor team"
        puts ""
        puts "Example: h:fg => home team, field goal (3 points)"
        puts "Example: v:td => visitor team, touch down (7 points)"

        puts ""
        puts "End the game with CTRL+D"
      end

      def collect_team_input
        puts "Enter Home Team"
        football_scoreboard.home_team.set_name $stdin.readline.sub("\n", "")

        puts "Enter Team 2 Name"
        football_scoreboard.visitor_team.set_name $stdin.readline.sub("\n", "")
      end

      def begin_reading_scores
        STDIN.each_line do |str|
          input = str.sub("\n", "").split(":")
          team = input[0] == "h" ? football_scoreboard.home_team : football_scoreboard.visitor_team
          adjust_team_score(team, input[1])

          puts "Scoreboard: #{football_scoreboard.score}"
        end
      end

      def adjust_team_score(team, score_type)
        case score_type
        when "fg"
          puts "Field Goal, #{team.name}!"
          team.field_goal
        when "td"
          puts "Touch down, #{team.name}!"
          team.touchdown
        end
      end
    end

    desc "Entry point for CLI", "Pass visitor and home teams with a flag"
    def start(_args)
      collect_team_input
      print_initial_output

      begin
        begin_reading_scores
      rescue
        puts "The game as ended. Final scores: #{score}"
      end
    end
  end
end
