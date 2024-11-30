defmodule PhoenixUIWeb.PageControllerTest do
  use PhoenixUIWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert redirected_to(conn) == "/getting_started"
  end
end
