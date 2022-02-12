defmodule PoolWeb.ContestController do
  use PoolWeb, :controller

  alias Pool.Contests
  alias Pool.Contests.Contest

  def index(conn, _params) do
    contests = Contests.list_contests()
    render(conn, "index.html", contests: contests)
  end

  def new(conn, _params) do
    changeset = Contests.change_contest(%Contest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_user: current_user}} = conn, %{"contest" => contest_params}) do
    case Contests.create_contest(current_user, contest_params) do
      {:ok, contest} ->
        conn
        |> put_flash(:info, "Contest created successfully.")
        |> redirect(to: Routes.contest_path(conn, :show, contest))

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
    render(conn, "edit.html", contest: contest, changeset: changeset)
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
end
