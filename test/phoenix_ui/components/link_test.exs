defmodule PhoenixUI.Components.LinkTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{text: "text"}]
  end

  describe "link/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.a>
        <%= @text %>
      </.a>
      """

      html = rendered_to_string(markup)

      assert html =~ "<a "
      assert html =~ "class=\"link "
      assert html =~ assigns.text
      assert html =~ "</a>"
    end
  end
end
