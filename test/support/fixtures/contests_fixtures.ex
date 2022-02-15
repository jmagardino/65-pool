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

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        logo: "some logo",
        name: "some name"
      })
      |> Pool.Contests.create_team()

    team
  end
end
