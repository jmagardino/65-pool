defmodule Pool.Contests.Contest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contests" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(contest, attrs) do
    contest
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
