defmodule PhoenixUI.Components.TypographyTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{text: "text"}]
  end

  describe "typography/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.typography>
        <%= @text %>
      </.typography>
      """

      html = rendered_to_string(markup)

      assert html =~ "<p class=\"typography "
      assert html =~ assigns.text
      assert html =~ "</p>"
    end
  end
end
