defmodule PoolWeb.MyContestController do
  use PoolWeb, :controller

  alias Pool.Contests
  # alias Pool.Contests.Contest

  def index(conn, _params) do
    # TODO: Only fetch contests for current signed in account
    owned_contests = Contests.owned_contests(conn.assigns.current_user.id)
    joined_contests = Contests.joined_contests(conn.assigns.current_user.id)
    render(conn, "index.html", contests: owned_contests ++ joined_contests)
  end
end
