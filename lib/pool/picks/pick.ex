defmodule Pool.Picks.Pick do
  use Ecto.Schema
  import Ecto.Changeset

  schema "picks" do
    field :spread, Ecto.Enum, values: [:over, :under]
    field :game_id, :id
    field :user_id, :id
    field :ats_winner_team_id, :id
    field :outright_winner_team_id, :id
    field :contest_id, :id

    timestamps()
  end

  @doc false
  def changeset(pick, attrs) do
    pick
    |> cast(attrs, [:spread])
    |> validate_required([:spread])
  end
end
