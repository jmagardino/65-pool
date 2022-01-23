defmodule PoolWeb.PageController do
  use PoolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
