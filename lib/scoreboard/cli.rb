require "thor"
require_relative "./api"
require_relative "./football_scoreboard"
require_relative "./team"

module Scoreboard
  class Cli < Thor
    attr_reader :football_scoreboard
    no_commands do
      def initialize
        @football_scoreboard = Scoreboard::FootballScoreboard.new
      end
    end
    # Doing this a second time to avoid warnings. attr_reader may mess with it.
    no_commands do
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
        football_scoreboard.home_team.name = $stdin.readline.sub("\n", "")

        puts "Enter Team 2 Name"
        football_scoreboard.visitor_team.name = $stdin.readline.sub("\n", "")
      end

      def begin_reading_scores
        begin
          STDIN.each_line do |str|
            input = str.sub("\n", "").split(":")
            team = input[0] == "h" ? football_scoreboard.home_team : football_scoreboard.visitor_team
            adjust_team_score(team, input[1])

            puts "Scoreboard: #{football_scoreboard.score}"
          end
        rescue Exception => ex
          puts "Was error: #{ex}"
        end

        puts "Thanks for playing! Were sending the game data."
        Api.send_data(football_scoreboard)
        show_dashboard_url
      end

      def show_dashboard_url
        puts "Thanks for playing! View the scoreboard dashboard: #{Api.dashboard_url}"
        puts "Weve sent your scoreboard data to our servers! Thanks for submitting!"
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
      rescue Exception => ex
        puts "The game has ended. Final scores: #{football_scoreboard.score} - #{ex}"
      end
    end
  end
end
