defmodule Pool.Weather do
  # OpenWeather API calls
  # returns coordinates from city,[state],[country] input
  def geocode(city, state, country \\ "usa") do
    endpoint = "http://api.openweathermap.org/geo/1.0/direct"
    key = Application.get_env(:pool, :secret_key_openweather)
    url = "#{endpoint}?q=#{city},#{state},#{country}&appid=#{key}"
    res = HTTPoison.get!(url)
    body = Poison.decode!(res.body, keys: :atoms)
    data = List.first(body)
    [data.lat, data.lon]
  end

  # returns temp and weather icon
  def get_weather() do
    endpoint = "api.openweathermap.org/data/2.5/weather"
    key = Application.get_env(:pool, :secret_key_openweather)
    coords = geocode("los angeles", "ca")
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
