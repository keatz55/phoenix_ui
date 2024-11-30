defmodule PhoenixUIWeb.Components.AvatarTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Avatar

  setup do
    [assigns: %{}]
  end

  describe "avatar/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H(<.avatar />)

      html = rendered_to_string(markup)

      assert html =~ ~s(<div class="avatar )
      assert html =~ ~s(<span class="hero-user-mini icon")
    end
  end
end
