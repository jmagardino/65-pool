defmodule PoolWeb.PickController do
  use PoolWeb, :controller

  alias Pool.Picks
  alias Pool.Picks.Pick

  def index(conn, _params) do
    picks = Picks.list_picks()
    render(conn, "index.html", picks: picks)
  end

  def new(conn, _params) do
    changeset = Picks.change_pick(%Pick{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"pick" => pick_params, "contest_id" => contest_id, "game_id" => game_id}) do
    contest = Pool.Contests.get_contest!(contest_id)
    game = Pool.Games.get_game!(game_id)

    pick_params = Map.put(pick_params, "user_id", conn.assigns.current_user.id)

    case Picks.create_pick(contest, game, pick_params) do
      {:ok, _pick} ->
        conn
        |> put_flash(:info, "Pick created successfully.")
        |> redirect(to: Routes.contest_path(conn, :show, contest_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    pick = Picks.get_pick!(id)
    render(conn, "show.html", pick: pick)
  end

  def edit(conn, %{"id" => id}) do
    pick = Picks.get_pick!(id)
    changeset = Picks.change_pick(pick)
    render(conn, "edit.html", pick: pick, changeset: changeset)
  end

  def update(conn, %{"id" => id, "pick" => pick_params, "contest_id" => contest_id}) do
    pick = Picks.get_pick!(id)

    case Picks.update_pick(pick, pick_params) do
      {:ok, _pick} ->
        conn
        |> put_flash(:info, "Pick updated successfully.")
        |> redirect(to: Routes.contest_path(conn, :show, contest_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", pick: pick, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    pick = Picks.get_pick!(id)
    {:ok, _pick} = Picks.delete_pick(pick)

    conn
    |> put_flash(:info, "Pick deleted successfully.")
    |> redirect(to: Routes.pick_path(conn, :index))
  end
end
