defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  def index(conn, _params) do
    weather = get_weather()
    render(conn, "index.html", weather: weather)
  end

  # OpenWeather API calls
  def geocode() do  # returns coordinates from city,[state],[country] input
    endpoint = "http://api.openweathermap.org/geo/1.0/direct"
    key = "90e450a4996778f8bb2bd339c6f51ef7"
    city = "los angeles"
    state = "ca"
    country = ""
    url = "#{endpoint}?q=#{city},#{state},#{country}&appid=#{key}"
    res = HTTPoison.get!(url)
    body = Poison.decode!(res.body, keys: :atoms)
    data = List.first(body)
    [data.lat, data.lon]
  end

  def get_weather() do  # returns temp and weather icon
    endpoint = "api.openweathermap.org/data/2.5/weather"
    key = "90e450a4996778f8bb2bd339c6f51ef7"
    coords = geocode()
    lat = Enum.at(coords, 0)
    lon = Enum.at(coords, 1)
    url = "#{endpoint}?lat=#{lat}&lon=#{lon}&appid=#{key}&units=imperial"
    res = HTTPoison.get!(url)
    body = Poison.decode!(res.body, keys: :atoms)
    metrics = body.main
    weather = List.first(body.weather)
    icon = "http://openweathermap.org/img/wn/#{weather.icon}@2x.png"
    weather_data = %{temp: round(metrics.temp), icon: icon}
    weather_data
  end
end
