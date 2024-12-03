defmodule PhoenixUIWeb.Components.DividerTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Divider

  setup do
    [assigns: %{}]
  end

  describe "divider/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H(<.divider />)
      html = rendered_to_string(markup)
      assert html =~ ~s(<hr )
      assert html =~ ~s(class="divider )
      assert html =~ ~s(role="presentation")
      assert html =~ ~s(border-zinc-950/10 dark:border-white/10)
      refute html =~ ~s(border-zinc-950/5 dark:border-white/5)
    end

    test "should render soft divider", %{assigns: assigns} do
      markup = ~H(<.divider soft />)
      html = rendered_to_string(markup)
      assert html =~ ~s(border-zinc-950/5 dark:border-white/5)
      refute html =~ ~s(border-zinc-950/10 dark:border-white/10)
    end
  end
end
