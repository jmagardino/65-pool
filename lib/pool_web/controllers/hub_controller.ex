defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  alias Pool.Games
  alias Pool.Contests

  def index(conn, _params) do
    games = Games.list_games()
    contests = Contests.list_contests()
    date = DateTime.utc_now()

    render(conn, "index.html",
      games: games,
      contests: contests,
      date: date
    )
  end
end
