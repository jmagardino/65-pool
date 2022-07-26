defmodule Pool.Weather do
  # OpenWeather API calls
  alias Pool.SportsData

  def stadium_weather(team) do
    target = "/data/2.5/weather?"
    stadium = SportsData.get_team_details(team).stadium_details
    [lat, lon] = [stadium["GeoLat"], stadium["GeoLong"]]
    query = %{"lat" => lat, "lon" => lon, "units" => "imperial"}
    %{main: metrics, weather: [weather | _tail]} = make_call(target, query)
    %{temp: round(metrics.temp), code: weather.icon}
  end

  # returns temp and weather icon
  def get_weather(city, state, country \\ "us") do
    target = "/data/2.5/weather?"
    [lat, lon] = geocode(city, state)
    query = %{"lat" => lat, "lon" => lon, "units" => "imperial"}
    %{main: metrics, weather: [weather | _tail]} = make_call(target, query)
    %{temp: round(metrics.temp), code: weather.icon}
  end

  # returns coordinates from city,[state],[country] input
  def geocode(city, state, country \\ "us") do
    target = "/geo/1.0/direct?"
    query = %{"q" => city <> "," <> state <> "," <> country}
    [%{lat: lat, lon: lon} | _tail] = make_call(target, query)
    [lat, lon]
  end

  # structures the API call url
  def make_call(target, query) do
    config = Application.get_env(:pool, __MODULE__)
    key = Keyword.fetch!(config, :secret_key_openweather)
    endpoint = Keyword.fetch!(config, :endpoint_openweather)
    query = Map.put(query, "appid", key)
    res = HTTPoison.get!(endpoint <> target <> URI.encode_query(query))
    Poison.decode!(res.body, keys: :atoms)
  end
end
