defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  alias Pool.Weather
  alias PoolWeb.HubView

  def index(conn, _params) do
    weather_data = Weather.get_weather()
    weather_icon = HubView.return_icon()
    render(conn, "index.html", weather: weather_data, icon: weather_icon)
  end
end
