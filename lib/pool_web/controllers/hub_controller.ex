defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  alias Pool.Weather
  alias Pool.SportsData
  alias Pool.Games

  def index(conn, _params) do
    weather_data = Weather.get_weather()
    games = Games.list_games()
    render(conn, "index.html", games: games, weather: weather_data, team_data: SportsData)
  end
end
