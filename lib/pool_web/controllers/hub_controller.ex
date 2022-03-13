defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  alias Pool.Weather
  alias Pool.SportsData

  def index(conn, _params) do
    weather_data = Weather.get_weather()
    render(conn, "index.html", weather: weather_data, team_data: SportsData)
  end
end
