defmodule Pool.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :over_under, :decimal
    field :spread, :decimal
    field :start, :utc_datetime
    field :forecast_temp, :integer
    field :forecast_desc, :string
    field :forecast_wind, :integer

    belongs_to :home_team, Pool.Games.Team
    belongs_to :away_team, Pool.Games.Team

    many_to_many :contests, Pool.Contests.Contest, join_through: "contests_games"
    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:start, :spread, :over_under, :forecast_temp, :forecast_desc, :forecast_wind])
    |> validate_required([:start, :spread, :over_under, :forecast_temp, :forecast_desc, :forecast_wind])
  end

  def teams_changeset(game, home_team, away_team) do
    game
    |> Ecto.Changeset.change(%{})
    |> Ecto.Changeset.put_assoc(:home_team, home_team)
    |> Ecto.Changeset.put_assoc(:away_team, away_team)
  end
end
