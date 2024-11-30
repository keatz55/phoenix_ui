defmodule PhoenixUIWeb.Components.AvatarGroupTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.AvatarGroup

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

      assert html =~ ~s(<div class="avatar-group )
      assert html =~ ~s(<div class="avatar )
      assert html =~ ~s(<span class="hero-user-mini icon")
    end
  end
end
