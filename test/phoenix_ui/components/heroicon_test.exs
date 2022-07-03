defmodule PhoenixUI.Components.HeroiconTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "heroicon/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.heroicon name="academic-cap"/>
      """

      html = rendered_to_string(markup)

      assert html =~ "<svg class=\"heroicon "
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = PhoenixUI.Components.Heroicon.classes()
    end
  end
end
