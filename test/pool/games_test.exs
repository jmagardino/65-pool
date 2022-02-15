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
end
