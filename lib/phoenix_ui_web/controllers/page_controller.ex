defmodule PhoenixUIWeb.PageController do
  @moduledoc """
  Page controller
  """
  use PhoenixUIWeb, :controller

  @doc """
  The home page is often custom made, so skip the default app layout.
  """
  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
