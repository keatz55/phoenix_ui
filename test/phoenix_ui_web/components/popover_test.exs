defmodule PhoenixUIWeb.Components.PopoverTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Popover

  setup do
    [assigns: %{}]
  end

  describe "popover/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H(<.popover id="popover">Content</.popover>)
      html = rendered_to_string(markup)
      assert html =~ ~s(id="popover")
      assert html =~ ~s(id="popover-backdrop")
      assert html =~ ~s( popover )
      assert html =~ ~s(class="backdrop )
      assert html =~ ~s(top-full left-1/2 -translate-x-1/2)
      assert html =~ ~s(Content)
      refute html =~ ~s( data-open)
    end

    test "should render with extended class", %{assigns: assigns} do
      markup = ~H(<.popover class="extend-class" id="popover"></.popover>)
      html = rendered_to_string(markup)
      assert html =~ ~s(extend-class)
    end

    test "should render open by default", %{assigns: assigns} do
      markup = ~H(<.popover default_open id="popover"></.popover>)
      html = rendered_to_string(markup)
      assert html =~ ~s(data-open)
    end

    test "should render set position", %{assigns: assigns} do
      markup = ~H(<.popover id="popover" position="right_end"></.popover>)
      html = rendered_to_string(markup)
      assert html =~ ~s(left-full bottom-0)
    end

    test "should render with set `:rest` attribute", %{assigns: assigns} do
      markup = ~H(<.popover data-test id="popover"></.popover>)
      html = rendered_to_string(markup)
      assert html =~ ~s(data-test)
    end
  end
end
