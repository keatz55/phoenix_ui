defmodule Phoenix.UI.Components.BackdropTest do
  use Phoenix.UI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "backdrop/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.backdrop id="basic-backdrop" />
      """

      html = rendered_to_string(markup)

      assert html =~ "<div id=\"basic-backdrop\" class=\"backdrop "
    end
  end
end
