defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  alias Pool.Weather
  alias PoolWeb.HubView

  def index(conn, _params) do
    weather_data = Weather.get_weather()
    render(conn, "index.html", weather: weather_data)
  end
end
