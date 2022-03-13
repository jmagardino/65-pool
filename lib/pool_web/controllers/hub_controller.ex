defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  alias Pool.Weather
  alias Pool.SportsData
  alias Pool.Games
  alias Pool.Contests

  def index(conn, _params) do
    weather_data = Weather.get_weather()
    games = Games.list_games()
    contests = Contests.list_contests()
    date = DateTime.utc_now()
    render(conn, "index.html", games: games, contests: contests, date: date, weather: weather_data, team_data: SportsData)
  end
end
