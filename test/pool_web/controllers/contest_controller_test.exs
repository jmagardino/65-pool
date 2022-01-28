defmodule PoolWeb.ContestControllerTest do
  use PoolWeb.ConnCase

  import Pool.ContestsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all contests", %{conn: conn} do
      conn = get(conn, Routes.contest_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Contests"
    end
  end

  describe "new contest" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.contest_path(conn, :new))
      assert html_response(conn, 200) =~ "New Contest"
    end
  end

  describe "create contest" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.contest_path(conn, :create), contest: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.contest_path(conn, :show, id)

      conn = get(conn, Routes.contest_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Contest"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.contest_path(conn, :create), contest: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Contest"
    end
  end

  describe "edit contest" do
    setup [:create_contest]

    test "renders form for editing chosen contest", %{conn: conn, contest: contest} do
      conn = get(conn, Routes.contest_path(conn, :edit, contest))
      assert html_response(conn, 200) =~ "Edit Contest"
    end
  end

  describe "update contest" do
    setup [:create_contest]

    test "redirects when data is valid", %{conn: conn, contest: contest} do
      conn = put(conn, Routes.contest_path(conn, :update, contest), contest: @update_attrs)
      assert redirected_to(conn) == Routes.contest_path(conn, :show, contest)

      conn = get(conn, Routes.contest_path(conn, :show, contest))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, contest: contest} do
      conn = put(conn, Routes.contest_path(conn, :update, contest), contest: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Contest"
    end
  end

  describe "delete contest" do
    setup [:create_contest]

    test "deletes chosen contest", %{conn: conn, contest: contest} do
      conn = delete(conn, Routes.contest_path(conn, :delete, contest))
      assert redirected_to(conn) == Routes.contest_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.contest_path(conn, :show, contest))
      end
    end
  end

  defp create_contest(_) do
    contest = contest_fixture()
    %{contest: contest}
  end
end
