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

  @doc """
  Gets a single contest.

  Raises `Ecto.NoResultsError` if the Contest does not exist.

  ## Examples

      iex> get_contest!(123)
      %Contest{}

      iex> get_contest!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contest!(id), do: Repo.get!(Contest, id)

  @doc """
  Creates a contest.

  ## Examples

      iex> create_contest(%{field: value})
      {:ok, %Contest{}}

      iex> create_contest(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contest(attrs \\ %{}) do
    %Contest{}
    |> Contest.changeset(attrs)
    |> Repo.insert()
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
end
