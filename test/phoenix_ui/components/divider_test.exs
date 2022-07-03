defmodule PhoenixUI.Components.DividerTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "divider/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.divider />
      """

      html = rendered_to_string(markup)

      assert html =~ "<hr class=\"divider "
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = PhoenixUI.Components.Divider.classes()
    end
  end
end
