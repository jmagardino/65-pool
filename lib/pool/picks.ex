defmodule Pool.Picks do
  @moduledoc """
  The Picks context.
  """

  import Ecto.Query, warn: false
  alias Pool.Repo

  alias Pool.Picks.Pick

  @doc """
  Returns the list of picks.

  ## Examples

      iex> list_picks()
      [%Pick{}, ...]

  """
  def list_picks do
    Repo.all(Pick)
  end

  @doc """
  Gets a single pick.

  Raises `Ecto.NoResultsError` if the Pick does not exist.

  ## Examples

      iex> get_pick!(123)
      %Pick{}

      iex> get_pick!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pick!(id), do: Repo.get!(Pick, id)

  @doc """
  Creates a pick.

  ## Examples

      iex> create_pick(%{field: value})
      {:ok, %Pick{}}

      iex> create_pick(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pick(attrs \\ %{}) do
    %Pick{}
    |> Pick.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pick.

  ## Examples

      iex> update_pick(pick, %{field: new_value})
      {:ok, %Pick{}}

      iex> update_pick(pick, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pick(%Pick{} = pick, attrs) do
    pick
    |> Pick.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pick.

  ## Examples

      iex> delete_pick(pick)
      {:ok, %Pick{}}

      iex> delete_pick(pick)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pick(%Pick{} = pick) do
    Repo.delete(pick)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pick changes.

  ## Examples

      iex> change_pick(pick)
      %Ecto.Changeset{data: %Pick{}}

  """
  def change_pick(%Pick{} = pick, attrs \\ %{}) do
    Pick.changeset(pick, attrs)
  end
end
