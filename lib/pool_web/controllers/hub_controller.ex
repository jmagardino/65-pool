defmodule PoolWeb.HubController do
  use PoolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
