defmodule PoolWeb.HubView do
  use PoolWeb, :view
  alias Pool.Contests
  alias Pool.SportsData

  def get_forecast(game_id) do
    game = Enum.find(SportsData.get_all_games(), fn g -> g["GlobalGameID"] == game_id end)
    [temp: game["ForecastWindChill"], icon: weather_icon(game["ForecastDescription"]), wind: game["ForecastWindSpeed"]]
  end

  # sets weather icon (based on sportsdata game-time forecast description)
  def weather_icon(desc) do
    case desc do
      "Clear Sky" -> "fa-solid fa-sun"
      "Few Clouds" -> "fa-solid fa-sun-cloud"
      "Scattered Clouds" -> "fa-solid fa-cloud-sun"
      "Broken Clouds" -> "fa-solid fa-cloud-sun"
      "Overcast Clouds" -> "fa-solid fa-clouds-sun"
      "Light Rain" -> "fa-solid fa-cloud-drizzle"
      "Moderate Rain" -> "fa-solid fa-cloud-rain"
      "Heavy Intensity Rain" -> "fa-solid fa-cloud-rain"
      "Snow" -> "fa-solid fa-snowflakes"
      nil -> ""
      # "Clear Sky" -> "fa-solid fa-moon-stars"
      # "Few Clouds" -> "fa-solid fa-moon-cloud"
      # "Scattered Clouds" -> "fa-solid fa-cloud-moon"
      # "Overcast Clouds" -> "fa-solid fa-clouds-moon"
      # "Heavy Intensity Rain" -> "fa-solid fa-cloud-moon-rain"
    end
  end

  # sets weather icon (based on openweather code)
  # def set_icon(code) do
  #   case code do
  #     "01d" -> "fa-solid fa-sun"
  #     "01n" -> "fa-solid fa-moon-stars"
  #     "02d" -> "fa-solid fa-sun-cloud"
  #     "02n" -> "fa-solid fa-moon-cloud"
  #     "03d" -> "fa-solid fa-cloud-sun"
  #     "03n" -> "fa-solid fa-cloud-moon"
  #     "04d" -> "fa-solid fa-clouds-sun"
  #     "04n" -> "fa-solid fa-clouds-moon"
  #     "09d" -> "fa-solid fa-cloud-drizzle"
  #     "09n" -> "fa-solid fa-cloud-moon-rain"
  #     "10d" -> "fa-solid fa-cloud-rain"
  #     "10n" -> "fa-solid fa-cloud-moon-rain"
  #     "11d" -> "fa-solid fa-cloud-bolt"
  #     "11n" -> "fa-solid fa-cloud-bolt-moon"
  #     "13d" -> "fa-solid fa-snowflakes"
  #     "13n" -> "fa-solid fa-snowflakes"
  #     "50d" -> "fa-solid fa-cloud-fog"
  #     "50n" -> "fa-solid fa-cloud-fog"
  #   end
  # end

  # TODO -- format date/time properly
  def format_date(date) do
    "#{date.month}/#{date.day} #{date.hour}:#{date.minute}"
  end

  # places the spread text next to the favorite team
  # def position_spread() do
  #   if Games.game.spread > 0 do

  #   end
  # end
end
