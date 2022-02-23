defmodule PoolWeb.LayoutController do
  use PoolWeb, :controller

  def header(conn, _params) do
    render(conn, "_header.html")
  end
end
