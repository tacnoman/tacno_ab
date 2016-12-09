defmodule TacnoAb.PageController do
  use TacnoAb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
