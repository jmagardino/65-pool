defmodule Pool.SportsData do
  # SportsDataIO API

  # --- Utility Functions --- #

  def make_call(endpoint, params \\ %{}) do
    config = Application.get_env(:pool, __MODULE__)
    key = Keyword.fetch!(config, :secret_key_sportsdata)
    endpoint = endpoint
    query = %{key: key}

    if Enum.count(params) > 0 do
      Map.merge(query, params)
    end

    res = HTTPoison.get!(endpoint <> "?" <> URI.encode_query(query))
    # Poison.decode!(res.body, keys: :atoms)
    Poison.decode!(res.body)
  end

  # --- Team Data --- #

  # Data for all current NFL teams
  @type search_key() :: String.t() | nil
  @spec get_all_teams(search_key()) :: any()
  def get_all_teams(key \\ nil) do
    endpoint = "https://api.sportsdata.io/v3/nfl/scores/json/Teams"
    data = make_call(endpoint)

    if !key do
      data
    else
      for %{^key => value} <- data, do: value
    end
  end

  def get_team_details(team_key) do
    team_keys = Pool.SportsData.get_all_teams("Key")
    i = Enum.find_index(team_keys, fn t -> t == team_key end)
    team_details = Enum.zip([Enum.at(team_keys, i)], [map_team_details(i)]) |> Enum.into(%{})
    team_details[team_key]
  end

  def map_team_details(i) do
    %{
      key: Enum.at(Pool.SportsData.get_all_teams("Key"), i),
      name: Enum.at(Pool.SportsData.get_all_teams("Name"), i),
      city: Enum.at(Pool.SportsData.get_all_teams("City"), i),
      full_name: Enum.at(Pool.SportsData.get_all_teams("FullName"), i),
      global_id: Enum.at(Pool.SportsData.get_all_teams("GlobalTeamID"), i),
      logo: Enum.at(Pool.SportsData.get_all_teams("WikipediaLogoUrl"), i),
      conference: Enum.at(Pool.SportsData.get_all_teams("Conference"), i),
      division: Enum.at(Pool.SportsData.get_all_teams("Division"), i),
      stadium_details: Enum.at(Pool.SportsData.get_all_teams("StadiumDetails"), i),
      colors: %{
        a: Enum.at(Pool.SportsData.get_all_teams("PrimaryColor"), i),
        b: Enum.at(Pool.SportsData.get_all_teams("SecondaryColor"), i),
        c: Enum.at(Pool.SportsData.get_all_teams("TertiaryColor"), i),
        d: Enum.at(Pool.SportsData.get_all_teams("QuaternaryColor"), i)
      }
    }
  end

  # --- Game Data --- #

  # General data for all games in a specified season
  @spec get_all_games(search_key()) :: any()
  def get_all_games(key \\ nil, season \\ 2021) do
    endpoint = "https://api.sportsdata.io/v3/nfl/scores/json/Schedules/#{season}"
    data = make_call(endpoint)

    if !key do
      data
    else
      for %{^key => value} <- data, do: value
    end
  end

  # Odds and general data for games in a specified week
  @spec get_game_odds_by_week(search_key()) :: any()
  def get_game_odds_by_week(key \\ nil, season \\ 2021, week \\ 1) do
    endpoint = "https://api.sportsdata.io/v3/nfl/odds/json/GameOddsByWeek/#{season}/#{week}"
    data = make_call(endpoint)

    if !key do
      data
    else
      for %{^key => value} <- data, do: value
    end
  end

  def get_game_odds_details(game_id) do
    game_ids = Pool.SportsData.get_game_odds_by_week("GlobalGameId")
    i = Enum.find_index(game_ids, fn g -> g == game_id end)
    game_details = Enum.zip([Enum.at(game_ids, i)], [map_game_details(i)]) |> Enum.into(%{})
    game_details[game_id]
  end

  def map_game_details(i) do
    %{
      global_id: Enum.at(Pool.SportsData.get_game_odds_by_week("GlobalGameId"), i),
      pregame_odds: Enum.at(Enum.at(Pool.SportsData.get_game_odds_by_week("PregameOdds"), 0), i)
    }
  end

  def get_forecast(game_id) do
    game = Enum.find(get_all_games(), fn g -> g["GlobalGameID"] == game_id end)
    [temp: game["ForecastWindChill"], icon: weather_icon(game["ForecastDescription"]), wind: game["ForecastWindSpeed"]]
  end

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
      # night time icons
      # "Clear Sky" -> "fa-solid fa-moon-stars"
      # "Few Clouds" -> "fa-solid fa-moon-cloud"
      # "Scattered Clouds" -> "fa-solid fa-cloud-moon"
      # "Overcast Clouds" -> "fa-solid fa-clouds-moon"
      # "Heavy Intensity Rain" -> "fa-solid fa-cloud-moon-rain"
    end
  end
end
