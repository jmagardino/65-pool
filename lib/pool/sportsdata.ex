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
  @type search_key() :: String.t()
  @spec get_all_teams(search_key()) :: any()
  def get_all_teams(key) do
    endpoint = "https://api.sportsdata.io/v3/nfl/scores/json/Teams"
    data = make_call(endpoint)
    for %{^key => value} <- data, do: value
  end

  def get_team_details(team_key) do
    team_keys = Pool.SportsData.get_all_teams("Key")
    i = Enum.find_index(team_keys, fn t -> t == team_key end)
    team_details = Enum.zip([Enum.at(team_keys, i)], [map_details(i)]) |> Enum.into(%{})
    team_details[team_key]
  end

  def get_team_details_by_id(team_id) do
    team_ids = Pool.SportsData.get_all_teams("TeamID")
    i = Enum.find_index(team_ids, fn t -> t == team_id end)
    team_details = Enum.zip([Enum.at(team_ids, i)], [map_details(i)]) |> Enum.into(%{})
    team_details[team_id]
  end

  def map_details(i) do
    %{
      name: Enum.at(Pool.SportsData.get_all_teams("Name"), i),
      city: Enum.at(Pool.SportsData.get_all_teams("City"), i),
      full_name: Enum.at(Pool.SportsData.get_all_teams("FullName"), i),
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
end
