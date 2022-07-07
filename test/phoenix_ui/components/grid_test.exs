defmodule PhoenixUI.Components.GridTest do
  use PhoenixUI.Case, async: true

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
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = PhoenixUI.Components.Grid.classes()
    end
  end
end
