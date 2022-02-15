defmodule Pool.Games.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :logo, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name, :logo])
    |> validate_required([:name, :logo])
  end
end
