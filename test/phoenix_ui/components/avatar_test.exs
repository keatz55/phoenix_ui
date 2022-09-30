defmodule PhoenixUI.Components.AvatarTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "avatar/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.avatar />
      """

      html = rendered_to_string(markup)

      assert html =~ "<div class=\"avatar "
      assert html =~ "<svg class=\"heroicon "
    end
  end
end
