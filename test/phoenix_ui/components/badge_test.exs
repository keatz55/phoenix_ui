defmodule PhoenixUI.Components.BadgeTest do
  alias PhoenixUI.Components.Badge

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

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = Badge.classes()
    end
  end
end
