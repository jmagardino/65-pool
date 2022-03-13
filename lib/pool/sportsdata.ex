defmodule Pool.SportsData do
  # SportsDataIO API
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
    team_details = Enum.zip([Enum.at(team_keys, i)], [map_details(i)]) |> Enum.into(%{})
    team_details[team_key]
  end

  def map_details(i) do
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

  # Data for all games in a season
  @spec get_all_games(search_key()) :: any()
  def get_all_games(key \\ nil, season \\ "2021") do
    endpoint = "https://api.sportsdata.io/v3/nfl/scores/json/Schedules/#{season}"
    data = make_call(endpoint)

    if !key do
      data
    else
      for %{^key => value} <- data, do: value
    end
  end
end
