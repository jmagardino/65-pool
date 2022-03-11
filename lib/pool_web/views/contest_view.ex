defmodule PoolWeb.ContestView do
  use PoolWeb, :view

  def set_avatar() do
    img_id = to_string(Enum.random(1..200))
    "https://picsum.photos/id/" <> img_id <> "/200/300"
  end
end
