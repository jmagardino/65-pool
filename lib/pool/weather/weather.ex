defmodule Pool.Weather do
  # OpenWeather API calls
  # returns coordinates from city,[state],[country] input
  def geocode() do
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

  # returns temp and weather icon
  def get_weather() do
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
