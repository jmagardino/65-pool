defmodule Pool.Contests.Contest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "contests" do
    field :name, :string

    belongs_to :owner_account, Pool.Accounts.User

    many_to_many :users, Pool.Accounts.User, join_through: "contests_users", on_replace: :delete
    many_to_many :games, Pool.Games.Game, join_through: "contests_games"

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

  def add_user_changeset(contest, user) do
    contest
    |> Ecto.Changeset.change(%{})
    # TODO: Change this to just insert the ids in the join table, not worry about
    |> Ecto.Changeset.put_assoc(:users, [user | contest.users])
  end

  def add_games_changeset(contest, [games]) do
    contest
    |> Ecto.Changeset.change(%{})
    |> Ecto.Changeset.put_assoc(:games, contest.games ++ [games])
  end
end
