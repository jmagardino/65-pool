defmodule PoolWeb.PickControllerTest do
  use PoolWeb.ConnCase

  import Pool.PicksFixtures

  @create_attrs %{point_total: :over}
  @update_attrs %{point_total: :under}
  @invalid_attrs %{point_total: nil}

  describe "index" do
    test "lists all picks", %{conn: conn} do
      conn = get(conn, Routes.pick_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Picks"
    end
  end

  describe "new pick" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.pick_path(conn, :new))
      assert html_response(conn, 200) =~ "New Pick"
    end
  end

  describe "create pick" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pick_path(conn, :create), pick: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.pick_path(conn, :show, id)

      conn = get(conn, Routes.pick_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Pick"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pick_path(conn, :create), pick: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Pick"
    end
  end

  describe "edit pick" do
    setup [:create_pick]

    test "renders form for editing chosen pick", %{conn: conn, pick: pick} do
      conn = get(conn, Routes.pick_path(conn, :edit, pick))
      assert html_response(conn, 200) =~ "Edit Pick"
    end
  end

  describe "update pick" do
    setup [:create_pick]

    test "redirects when data is valid", %{conn: conn, pick: pick} do
      conn = put(conn, Routes.pick_path(conn, :update, pick), pick: @update_attrs)
      assert redirected_to(conn) == Routes.pick_path(conn, :show, pick)

      conn = get(conn, Routes.pick_path(conn, :show, pick))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, pick: pick} do
      conn = put(conn, Routes.pick_path(conn, :update, pick), pick: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Pick"
    end
  end

  describe "delete pick" do
    setup [:create_pick]

    test "deletes chosen pick", %{conn: conn, pick: pick} do
      conn = delete(conn, Routes.pick_path(conn, :delete, pick))
      assert redirected_to(conn) == Routes.pick_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.pick_path(conn, :show, pick))
      end
    end
  end

  defp create_pick(_) do
    pick = pick_fixture()
    %{pick: pick}
  end
end
