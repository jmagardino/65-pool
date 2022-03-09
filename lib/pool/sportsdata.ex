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
end
