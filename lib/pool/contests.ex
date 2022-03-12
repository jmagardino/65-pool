defmodule Pool.Contests do
  @moduledoc """
  The Contests context.
  """

  import Ecto.Query, warn: false
  alias Pool.Repo

  alias Pool.Contests.Contest

  @doc """
  Returns the list of contests.

  ## Examples

      iex> list_contests()
      [%Contest{}, ...]

  """
  def list_contests do
    Repo.all(Contest)
  end

  def joinable_contests(user_id) do
    query = from c in Contest, where: c.owner_account_id != ^user_id

    Repo.all(query)
  end

  def owned_contests(user_id) do
    query = from c in Contest, where: c.owner_account_id == ^user_id

    Repo.all(query)
  end

  def joined_contests(user_id) do
    query =
      from c in Contest, join: u in assoc(c, :users), preload: [users: u], where: u.id == ^user_id

    Repo.all(query)
  end

  @doc """
  Gets a single contest.

  Raises `Ecto.NoResultsError` if the Contest does not exist.

  ## Examples

      iex> get_contest!(123)
      %Contest{}

      iex> get_contest!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contest!(id),
    do:
      Repo.get!(Contest, id)
      |> Repo.preload([:users, picks: [:game], games: [:home_team, :away_team]])

  @doc """
  Creates a contest.

  ## Examples

      iex> create_contest(%{field: value})
      {:ok, %Contest{}}

      iex> create_contest(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contest(user, attrs \\ %{}) do
    IO.inspect(attrs, label: "1")
    %Contest{}
    |> Contest.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:owner_account, user)
    |> Repo.insert()
  end

  def add_user!(%Contest{} = contest, user) do
    contest
    |> Repo.preload(:users)
    |> Contest.add_user_changeset(user)
    |> Repo.update!()
  end

  def set_games_for_contest(%Contest{} = contest, [_ | _] = games) do
    contest
    |> Repo.preload(games: [:home_team, :away_team])
    |> Contest.set_games_changeset(games)
    |> Repo.update!()
  end

  @doc """
  Updates a contest.

  ## Examples

      iex> update_contest(contest, %{field: new_value})
      {:ok, %Contest{}}

      iex> update_contest(contest, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contest(%Contest{} = contest, attrs) do
    contest
    |> Contest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contest.

  ## Examples

      iex> delete_contest(contest)
      {:ok, %Contest{}}

      iex> delete_contest(contest)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contest(%Contest{} = contest) do
    Repo.delete(contest)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contest changes.

  ## Examples

      iex> change_contest(contest)
      %Ecto.Changeset{data: %Contest{}}

  """
  def change_contest(%Contest{} = contest, attrs \\ %{}) do
    contest
    |> Pool.Repo.preload(:games)
    |> Contest.changeset(attrs)
  end
end
