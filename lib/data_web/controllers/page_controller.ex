defmodule DataWeb.PageController do
  use DataWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
