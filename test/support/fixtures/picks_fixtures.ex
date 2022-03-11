defmodule Pool.PicksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pool.Picks` context.
  """

  @doc """
  Generate a pick.
  """
  def pick_fixture(attrs \\ %{}) do
    {:ok, pick} =
      attrs
      |> Enum.into(%{
        spread: :over
      })
      |> Pool.Picks.create_pick()

    pick
  end
end
