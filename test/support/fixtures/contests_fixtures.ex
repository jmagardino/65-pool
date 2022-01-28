defmodule Pool.ContestsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pool.Contests` context.
  """

  @doc """
  Generate a contest.
  """
  def contest_fixture(attrs \\ %{}) do
    {:ok, contest} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Pool.Contests.create_contest()

    contest
  end
end
