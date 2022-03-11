defmodule Pool.PicksTest do
  use Pool.DataCase

  alias Pool.Picks

  describe "picks" do
    alias Pool.Picks.Pick

    import Pool.PicksFixtures

    @invalid_attrs %{spread: nil}

    test "list_picks/0 returns all picks" do
      pick = pick_fixture()
      assert Picks.list_picks() == [pick]
    end

    test "get_pick!/1 returns the pick with given id" do
      pick = pick_fixture()
      assert Picks.get_pick!(pick.id) == pick
    end

    test "create_pick/1 with valid data creates a pick" do
      valid_attrs = %{spread: :over}

      assert {:ok, %Pick{} = pick} = Picks.create_pick(valid_attrs)
      assert pick.spread == :over
    end

    test "create_pick/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Picks.create_pick(@invalid_attrs)
    end

    test "update_pick/2 with valid data updates the pick" do
      pick = pick_fixture()
      update_attrs = %{spread: :under}

      assert {:ok, %Pick{} = pick} = Picks.update_pick(pick, update_attrs)
      assert pick.spread == :under
    end

    test "update_pick/2 with invalid data returns error changeset" do
      pick = pick_fixture()
      assert {:error, %Ecto.Changeset{}} = Picks.update_pick(pick, @invalid_attrs)
      assert pick == Picks.get_pick!(pick.id)
    end

    test "delete_pick/1 deletes the pick" do
      pick = pick_fixture()
      assert {:ok, %Pick{}} = Picks.delete_pick(pick)
      assert_raise Ecto.NoResultsError, fn -> Picks.get_pick!(pick.id) end
    end

    test "change_pick/1 returns a pick changeset" do
      pick = pick_fixture()
      assert %Ecto.Changeset{} = Picks.change_pick(pick)
    end
  end
end
