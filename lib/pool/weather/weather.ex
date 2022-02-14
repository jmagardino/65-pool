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
    %{temp: round(metrics.temp), icon: set_icon(weather.icon)}
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

  # sets weather icon
  def set_icon(code) do
    case code do
      "01d" -> "fa-solid fa-sun"
      "01n" -> "fa-solid fa-moon-stars"
      "02d" -> "fa-solid fa-sun-cloud"
      "02n" -> "fa-solid fa-moon-cloud"
      "03d" -> "fa-solid fa-cloud-sun"
      "03n" -> "fa-solid fa-cloud-moon"
      "04d" -> "fa-solid fa-clouds-sun"
      "04n" -> "fa-solid fa-clouds-moon"
      "09d" -> "fa-solid fa-cloud-drizzle"
      "09n" -> "fa-solid fa-cloud-moon-rain"
      "10d" -> "fa-solid fa-cloud-rain"
      "10n" -> "fa-solid fa-cloud-moon-rain"
      "11d" -> "fa-solid fa-cloud-bolt"
      "11n" -> "fa-solid fa-cloud-bolt-moon"
      "13d" -> "fa-solid fa-snowflakes"
      "13n" -> "fa-solid fa-snowflakes"
      "50d" -> "fa-solid fa-cloud-fog"
      "50n" -> "fa-solid fa-cloud-fog"
    end
  end
end
