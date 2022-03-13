defmodule PoolWeb.ContestController do
  use PoolWeb, :controller

  alias Pool.Contests
  alias Pool.Contests.Contest
  alias Pool.Picks
  alias Pool.Picks.Pick

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

  def create(%{assigns: %{current_user: current_user}} = conn, %{
        "contest" => %{"game_ids" => game_ids} = contest_params
      }) do
    case Contests.create_contest(current_user, contest_params) do
      {:ok, contest} ->
        games = Enum.map(game_ids, fn id -> Pool.Games.get_game!(id) end)

        contest_with_games = Contests.set_games_for_contest(contest, games)

        conn
        |> put_flash(:info, "Contest created successfully.")
        |> redirect(to: Routes.contest_path(conn, :show, contest_with_games))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    contest = Contests.get_contest!(id)

    games_with_picks =
      Enum.filter(contest.games, fn game -> game_exists_in_picks(game, contest.picks) end)

    games_needing_picks =
      Enum.reject(contest.games, fn game -> game_exists_in_picks(game, contest.picks) end)

    existing_pick_games =
      Enum.map(games_with_picks, fn game ->
        {game, Enum.find(contest.picks, fn pick -> pick.game_id == game.id end),
         Pool.Picks.change_pick(Enum.find(contest.picks, fn pick -> pick.game_id == game.id end))}
      end)

    pick_changeset = Picks.change_pick(%Pick{})

    render(conn, "show.html",
      contest: contest,
      pick_changeset: pick_changeset,
      games_needing_picks: games_needing_picks,
      games_with_picks: games_with_picks,
      existing_pick_games: existing_pick_games
    )
  end

  def edit(conn, %{"id" => id}) do
    games = Pool.Games.list_games()
    contest = Contests.get_contest!(id)
    changeset = Contests.change_contest(contest)
    render(conn, "edit.html", contest: contest, changeset: changeset, games: games)
  end

  def update(conn, %{"id" => id, "contest" => %{"game_ids" => game_ids} = contest_params}) do
    contest = Contests.get_contest!(id)

    case Contests.update_contest(contest, contest_params) do
      {:ok, contest} ->
        games = Enum.map(game_ids, fn id -> Pool.Games.get_game!(id) end)

        contest_with_games = Contests.set_games_for_contest(contest, games)

        conn
        |> put_flash(:info, "Contest updated successfully.")
        |> redirect(to: Routes.contest_path(conn, :show, contest_with_games))

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

  defp game_exists_in_picks(game, picks) do
    Enum.count(picks, fn pick -> pick.game_id == game.id end) > 0
  end
end
