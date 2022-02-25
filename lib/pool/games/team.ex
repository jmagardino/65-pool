defmodule Pool.Games.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :logo, :string
    field :name, :string

    has_many :away_games, Pool.Games.Game, foreign_key: :home_team_id
    has_many :home_games, Pool.Games.Game, foreign_key: :away_team_id

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :logo])
    |> validate_required([:name, :logo])
  end
end
