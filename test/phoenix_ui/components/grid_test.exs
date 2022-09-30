defmodule Phoenix.UI.Components.GridTest do
  use Phoenix.UI.Case, async: true

  setup do
    [assigns: %{text: "text"}]
  end

  describe "grid/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.grid>
        <%= @text %>
      </.grid>
      """

      html = rendered_to_string(markup)

      assert html =~ "<div class=\"grid "
      assert html =~ assigns[:text]
    end
  end
end
