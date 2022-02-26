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

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        over_under: "120.5",
        spread: "120.5",
        start: ~U[2022-02-15 18:29:00Z]
      })
      |> Pool.Games.create_game()

    game
  end
end
