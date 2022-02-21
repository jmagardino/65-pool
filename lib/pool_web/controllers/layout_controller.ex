defmodule PoolWeb.LayoutController do
  use PoolWeb, :controller
  use PoolWeb.CurrentUser

  def header(conn, _params, current_user) do
    render(conn, "_header.html", current_user: current_user)
  end
end
