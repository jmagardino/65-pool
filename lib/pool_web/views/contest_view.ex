defmodule PoolWeb.ContestView do
  use PoolWeb, :view
  alias Pool.Contests

  def set_avatar() do
    img_id = to_string(Enum.random(1..200))
    "https://picsum.photos/id/" <> img_id <> "/200/300"
  end

  def next_picks_due(contest_id) do
    hd(Contests.next_game_start(contest_id))
    |> DateTime.to_unix()
    # |> Date.to_gregorian_days()
    # |> to_string()
  end
end
