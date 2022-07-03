defmodule PhoenixUI.Components.AvatarGroupTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "avatar_group/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.avatar_group>
        <:avatar />
        <:avatar />
      </.avatar_group>
      """

      html = rendered_to_string(markup)

      assert html =~ "<div class=\"avatar-group "
      assert html =~ "<div class=\"avatar "
      assert html =~ "<svg class=\"heroicon "
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = PhoenixUI.Components.AvatarGroup.classes()
    end
  end
end
