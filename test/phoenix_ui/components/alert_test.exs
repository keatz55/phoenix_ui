defmodule PhoenixUI.Components.AlertTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "alert/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.alert>
        Content
      </.alert>
      """

      html = rendered_to_string(markup)

      assert html =~ "<div role=\"alert\" class=\"alert "
      assert html =~ "<svg class=\"heroicon "
      assert html =~ "Content"
    end
  end
end
