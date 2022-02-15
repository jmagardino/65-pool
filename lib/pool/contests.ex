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
    query = from c in Contest, join: u in assoc(c, :users), preload: [users: u], where: u.id == ^user_id

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
  def get_contest!(id), do: Repo.get!(Contest, id) |> Repo.preload(:users)

  @doc """
  Creates a contest.

  ## Examples

      iex> create_contest(%{field: value})
      {:ok, %Contest{}}

      iex> create_contest(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contest(user, attrs \\ %{}) do
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
    Contest.changeset(contest, attrs)
  end

  alias Pool.Contests.Team

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end
end
