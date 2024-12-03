defmodule PhoenixUIWeb.Components.PaperTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Paper

  setup do
    [assigns: %{}]
  end

  describe "paper/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H(<.paper id="basic-paper">Content</.paper>)
      html = rendered_to_string(markup)
      assert html =~ ~s(<div )
      assert html =~ ~s(class="paper )
      assert html =~ ~s(backdrop-blur-xl)
      assert html =~ ~s(shadow-md)
      assert html =~ ~s(rounded-xl)
      assert html =~ ~s(Content)
    end

    test "should render without blurred background", %{assigns: assigns} do
      markup = ~H(<.paper blur={false}></.paper>)
      html = rendered_to_string(markup)
      refute html =~ ~s(backdrop-blur-xl)
    end

    test "should render with set element", %{assigns: assigns} do
      markup = ~H(<.paper element="nav"></.paper>)
      html = rendered_to_string(markup)
      assert html =~ ~s(<nav )
    end

    test "should render with set elevation", %{assigns: assigns} do
      for {style, elevation} <- Enum.with_index(~w(none sm md lg xl 2xl)) do
        assigns = Map.put(assigns, :elevation, elevation)
        markup = ~H(<.paper elevation={@elevation}></.paper>)
        assert rendered_to_string(markup) =~ "shadow-#{style}"
      end
    end

    test "should render with set `:rest` attribute", %{assigns: assigns} do
      markup = ~H(<.paper data-test></.paper>)
      html = rendered_to_string(markup)
      assert html =~ ~s(data-test)
    end

    test "should render with square edges", %{assigns: assigns} do
      markup = ~H(<.paper square></.paper>)
      html = rendered_to_string(markup)
      refute html =~ ~s(rounded-xl)
    end
  end
end
