defmodule ChatAppWeb.PageController do
  use ChatAppWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: session_path(conn, :new))
  end

  def dashboard(conn, _params) do
    render conn, "index.html"
  end
end
