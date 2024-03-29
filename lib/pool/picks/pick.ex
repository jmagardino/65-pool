defmodule Pool.Picks.Pick do
  use Ecto.Schema
  import Ecto.Changeset

  schema "picks" do
    field :point_total, Ecto.Enum, values: [:over, :under]

    belongs_to :contest, Pool.Contests.Contest
    belongs_to :game, Pool.Games.Game
    belongs_to :ats_winner_team, Pool.Games.Game
    belongs_to :outright_winner_team, Pool.Games.Game
    belongs_to :user, Pool.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(pick, attrs) do
    pick
    |> cast(attrs, [:point_total, :ats_winner_team_id, :outright_winner_team_id])
    |> validate_required([:point_total])
  end
end
