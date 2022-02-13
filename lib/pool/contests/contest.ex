defmodule Pool.Contests.Contest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contests" do
    field :name, :string

    belongs_to :owner_account, Pool.Accounts.User

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(contest, attrs) do
    contest
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
