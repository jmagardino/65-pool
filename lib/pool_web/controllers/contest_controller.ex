defmodule PoolWeb.ContestController do
  use PoolWeb, :controller

  alias Pool.Contests
  alias Pool.Contests.Contest

  def index(conn, _params) do
    # TODO: Don't list contests owned by current user
    contests = Contests.joinable_contests(conn.assigns.current_user.id)
    render(conn, "index.html", contests: contests)
  end

  def my_contests(conn, _params) do
    # TODO: Only fetch contests for current signed in account
    owned_contests = Contests.owned_contests(conn.assigns.current_user.id)
    joined_contests = Contests.joined_contests(conn.assigns.current_user.id)
    render(conn, "my_contests.html", contests: owned_contests ++ joined_contests)
  end

  def new(conn, _params) do
    changeset = Contests.change_contest(%Contest{})
    games = Pool.Games.list_games()
    render(conn, "new.html", changeset: changeset, games: games)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"contest" => %{"games" => game_ids} = contest_params}) do
    case Contests.create_contest(current_user, contest_params) do
      {:ok, contest} ->

        games = Enum.map(game_ids, fn id -> Pool.Games.get_game!(id) end)

        contest_with_games = Contests.add_games_to_contest(contest, games)

        conn
        |> put_flash(:info, "Contest created successfully.")
        |> redirect(to: Routes.contest_path(conn, :show, contest_with_games))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contest = Contests.get_contest!(id)
    render(conn, "show.html", contest: contest)
  end

  def edit(conn, %{"id" => id}) do
    contest = Contests.get_contest!(id)
    changeset = Contests.change_contest(contest)
    render(conn, "edit.html", games: [], contest: contest, changeset: changeset)
  end

  def update(conn, %{"id" => id, "contest" => contest_params}) do
    contest = Contests.get_contest!(id)

    case Contests.update_contest(contest, contest_params) do
      {:ok, contest} ->
        conn
        |> put_flash(:info, "Contest updated successfully.")
        |> redirect(to: Routes.contest_path(conn, :show, contest))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", contest: contest, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    contest = Contests.get_contest!(id)
    {:ok, _contest} = Contests.delete_contest(contest)

    conn
    |> put_flash(:info, "Contest deleted successfully.")
    |> redirect(to: Routes.contest_path(conn, :index))
  end

  def join(conn, %{"id" => contest_id}) do
    contest = Contests.get_contest!(contest_id)

    contest = Contests.add_user!(contest, conn.assigns.current_user)

    conn
    |> put_flash(:success, "Joined contest successfully!")
    |> redirect(to: Routes.contest_path(conn, :show, contest))
  end
end
