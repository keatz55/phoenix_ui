defmodule PhoenixUIWeb.Components.BackdropTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Backdrop

  setup do
    [assigns: %{}]
  end

  describe "backdrop/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H(<.backdrop id="basic-backdrop" />)
      html = rendered_to_string(markup)
      assert html =~ ~s(<div )
      assert html =~ ~s(id="basic-backdrop")
      assert html =~ ~s(class="backdrop )
      assert html =~ ~s(bg-zinc-900/25 backdrop-blur-sm)
      refute html =~ ~s(data-open)
    end

    test "should render open by default", %{assigns: assigns} do
      markup = ~H(<.backdrop default_open id="basic-backdrop" />)
      html = rendered_to_string(markup)
      assert html =~ ~s(data-open)
    end

    test "should render invisible backdrop", %{assigns: assigns} do
      markup = ~H(<.backdrop id="basic-backdrop" invisible />)
      html = rendered_to_string(markup)
      refute html =~ ~s(bg-zinc-900/25 backdrop-blur-sm)
    end
  end
end
