defmodule Phoenix.UI.Components.AvatarGroupTest do
  use Phoenix.UI.Case, async: true

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
end
