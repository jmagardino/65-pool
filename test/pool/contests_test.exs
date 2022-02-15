defmodule Pool.ContestsTest do
  use Pool.DataCase

  alias Pool.Contests

  describe "contests" do
    alias Pool.Contests.Contest

    import Pool.ContestsFixtures

    @invalid_attrs %{name: nil}

    test "list_contests/0 returns all contests" do
      contest = contest_fixture()
      assert Contests.list_contests() == [contest]
    end

    test "get_contest!/1 returns the contest with given id" do
      contest = contest_fixture()
      assert Contests.get_contest!(contest.id) == contest
    end

    test "create_contest/1 with valid data creates a contest" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Contest{} = contest} = Contests.create_contest(valid_attrs)
      assert contest.name == "some name"
    end

    test "create_contest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contests.create_contest(@invalid_attrs)
    end

    test "update_contest/2 with valid data updates the contest" do
      contest = contest_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Contest{} = contest} = Contests.update_contest(contest, update_attrs)
      assert contest.name == "some updated name"
    end

    test "update_contest/2 with invalid data returns error changeset" do
      contest = contest_fixture()
      assert {:error, %Ecto.Changeset{}} = Contests.update_contest(contest, @invalid_attrs)
      assert contest == Contests.get_contest!(contest.id)
    end

    test "delete_contest/1 deletes the contest" do
      contest = contest_fixture()
      assert {:ok, %Contest{}} = Contests.delete_contest(contest)
      assert_raise Ecto.NoResultsError, fn -> Contests.get_contest!(contest.id) end
    end

    test "change_contest/1 returns a contest changeset" do
      contest = contest_fixture()
      assert %Ecto.Changeset{} = Contests.change_contest(contest)
    end
  end

  describe "teams" do
    alias Pool.Contests.Team

    import Pool.ContestsFixtures

    @invalid_attrs %{logo: nil, name: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Contests.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Contests.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{logo: "some logo", name: "some name"}

      assert {:ok, %Team{} = team} = Contests.create_team(valid_attrs)
      assert team.logo == "some logo"
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Contests.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{logo: "some updated logo", name: "some updated name"}

      assert {:ok, %Team{} = team} = Contests.update_team(team, update_attrs)
      assert team.logo == "some updated logo"
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Contests.update_team(team, @invalid_attrs)
      assert team == Contests.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Contests.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Contests.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Contests.change_team(team)
    end
  end
end
