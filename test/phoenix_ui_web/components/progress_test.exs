defmodule PhoenixUIWeb.Components.ProgressTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Progress

  setup do
    [assigns: %{}]
  end

  describe "progress/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H(<.progress />)

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert hd(Floki.attribute(doc, "svg", "class")) =~ "progress "
    end

    test "should render with set color attr", %{assigns: assigns} do
      m1 = ~H(<.progress color="red" variant="linear" />)
      m2 = ~H(<.progress color="red" variant="radial" />)

      assert rendered_to_string(m1) =~ ~s(bg-red-500 text-red-100)
      assert rendered_to_string(m2) =~ ~s(text-red-500)
    end

    test "should render with set size attr", %{assigns: assigns} do
      m1 = ~H(<.progress size="sm" variant="linear" />)
      m2 = ~H(<.progress size="sm" variant="radial" />)

      assert rendered_to_string(m1) =~ ~s(h-3.5 text-xs)
      assert rendered_to_string(m2) =~ ~s(h-8 w-8 text-sm)
    end

    test "should render with set square attr", %{assigns: assigns} do
      m1 = ~H(<.progress square variant="linear" />)
      m2 = ~H(<.progress square variant="radial" />)

      refute rendered_to_string(m1) =~ ~s(rounded-full)
      refute rendered_to_string(m2) =~ ~s(rounded-full)
    end

    test "should render with set text attrs", %{assigns: assigns} do
      m1 = ~H(<.progress text="custom-text" variant="linear" />)
      m2 = ~H(<.progress text="custom-text" variant="radial" />)

      assert rendered_to_string(m1) =~ ~s(custom-text)
      assert rendered_to_string(m2) =~ ~s(custom-text)
    end

    test "should render with set value attrs", %{assigns: assigns} do
      m1 = ~H(<.progress value={50} variant="linear" />)
      m2 = ~H(<.progress value={50} variant="radial" />)

      assert rendered_to_string(m1) =~ ~s(width: 50%)
      assert rendered_to_string(m2) =~ ~s(stroke-dasharray="50, 100")
    end

    test "should render with extended classes", %{assigns: assigns} do
      markup = ~H(<.progress class="extended-class" />)

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert hd(Floki.attribute(doc, "svg", "class")) =~ "extended-class"
    end

    test "should render with set `:rest` attribute", %{assigns: assigns} do
      markup = ~H(<.progress data-test="abc" />)

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert Floki.attribute(doc, "svg", "data-test") == ["abc"]
    end
  end
end
