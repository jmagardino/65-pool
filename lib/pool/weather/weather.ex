defmodule Pool.Weather do
  # OpenWeather API calls

  # returns temp and weather icon
  def get_weather() do
    target = "/data/2.5/weather?"
    [lat, lon] = geocode("los angeles", "ca")
    query = %{"lat" => lat, "lon" => lon, "units" => "imperial"}
    url = build_call(target, query)
    res = HTTPoison.get!(url)
    %{main: metrics, weather: [weather | _tail]} = Poison.decode!(res.body, keys: :atoms)
    icon = "http://openweathermap.org/img/wn/#{weather.icon}@2x.png"
    %{temp: round(metrics.temp), icon: icon}
  end

  # returns coordinates from city,[state],[country] input
  def geocode(city, state, country \\ "us") do
    target = "/geo/1.0/direct?"
    query = %{"q" => city <> "," <> state <> "," <> country}
    url = build_call(target, query)
    res = HTTPoison.get!(url)
    body = Poison.decode!(res.body, keys: :atoms)
    data = List.first(body)
    [data.lat, data.lon]
  end

  # structures the API call url
  def build_call(target, query) do
    config = Application.get_env(:pool, __MODULE__)
    key = Keyword.fetch!(config, :secret_key_openweather)
    endpoint = Keyword.fetch!(config, :endpoint_openweather)
    query = Map.put(query, "appid", key)
    endpoint <> target <> URI.encode_query(query)
  end
end
