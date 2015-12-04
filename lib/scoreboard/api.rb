require "net/http"
require "uri"

module Scoreboard
  class Api
    def self.dashboard_url
      "http://localhost:3030/scoreboard"
    end

    def self.send_data(data)
      uri = URI.parse("http://localhost:9393/api/v1/results")

      # Shortcut
      response = Net::HTTP.post_form(uri,
        "home_team"     => data.home_team.name,
        "home_score"    => data.home_team.score,
        "visitor_team"  => data.visitor_team.name,
        "visitor_score" => data.visitor_team.score
      )
      response.code == 200
    end
  end
end
