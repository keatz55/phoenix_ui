defmodule Phoenix.UI.Components.DividerTest do
  use Phoenix.UI.Case, async: true

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
end
