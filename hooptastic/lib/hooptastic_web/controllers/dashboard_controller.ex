defmodule HooptasticWeb.DashboardController do
  use HooptasticWeb, :controller

  def index(conn, _param) do
    render(conn, "index.html")
  end
end
