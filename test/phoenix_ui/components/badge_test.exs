defmodule PhoenixUI.Components.BadgeTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "badge/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.badge content="99+">
        <.heroicon color="slate" name="envelope" />
      </.badge>
      """

      html = rendered_to_string(markup)

      assert html =~ "<div class=\"badge-wrapper "
      assert html =~ "<div class=\"badge "
      assert html =~ "99+"
    end
  end
end
