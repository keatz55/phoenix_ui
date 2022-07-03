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

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = PhoenixUI.Components.Avatar.classes()
    end
  end
end
