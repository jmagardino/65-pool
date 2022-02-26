defmodule Pool.GamesTest do
  use Pool.DataCase

  alias Pool.Games

  describe "teams" do
    alias Pool.Games.Team

    import Pool.GamesFixtures

    @invalid_attrs %{logo: nil, name: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Games.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Games.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{logo: "some logo", name: "some name"}

      assert {:ok, %Team{} = team} = Games.create_team(valid_attrs)
      assert team.logo == "some logo"
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{logo: "some updated logo", name: "some updated name"}

      assert {:ok, %Team{} = team} = Games.update_team(team, update_attrs)
      assert team.logo == "some updated logo"
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_team(team, @invalid_attrs)
      assert team == Games.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Games.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Games.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Games.change_team(team)
    end
  end

  describe "games" do
    alias Pool.Games.Game

    import Pool.GamesFixtures

    @invalid_attrs %{over_under: nil, spread: nil, start: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{over_under: "120.5", spread: "120.5", start: ~U[2022-02-15 18:29:00Z]}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.over_under == Decimal.new("120.5")
      assert game.spread == Decimal.new("120.5")
      assert game.start == ~U[2022-02-15 18:29:00Z]
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{over_under: "456.7", spread: "456.7", start: ~U[2022-02-16 18:29:00Z]}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.over_under == Decimal.new("456.7")
      assert game.spread == Decimal.new("456.7")
      assert game.start == ~U[2022-02-16 18:29:00Z]
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
