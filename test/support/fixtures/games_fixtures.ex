defmodule Pool.GamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pool.Games` context.
  """

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
      |> Pool.Games.create_team()

    team
  end
end
