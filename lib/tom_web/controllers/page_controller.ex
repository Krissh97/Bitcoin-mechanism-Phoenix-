defmodule TomWeb.PageController do
  use TomWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
