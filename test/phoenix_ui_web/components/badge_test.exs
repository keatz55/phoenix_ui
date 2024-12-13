defmodule PhoenixUIWeb.Components.BadgeTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Badge

  setup do
    [assigns: %{}]
  end

  describe "badge/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.badge>
        Emails
        <:badge>99+</:badge>
      </.badge>
      """

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert Floki.find(doc, "div.badge-wrapper") != []
      assert Floki.find(doc, "span.badge") != []
    end

    test "should render with set border attr", %{assigns: assigns} do
      markup = ~H"""
      <.badge border>
        Emails
        <:badge>99+</:badge>
      </.badge>
      """

      assert rendered_to_string(markup) =~ ~s(border-2)
    end

    test "should render with set color attr", %{assigns: assigns} do
      Enum.each(~w(red blue green), fn color ->
        assigns = Map.put(assigns, :color, color)

        markup = ~H"""
        <.badge color={@color}>
          Emails
          <:badge>99+</:badge>
        </.badge>
        """

        assert rendered_to_string(markup) =~ "bg-#{color}-600"
      end)
    end

    test "should render with set invisible attr", %{assigns: assigns} do
      markup = ~H"""
      <.badge invisible>
        Emails
        <:badge>99+</:badge>
      </.badge>
      """

      assert rendered_to_string(markup) =~ ~s(invisible)
    end

    test "should render with set position attr", %{assigns: assigns} do
      Enum.each(~w(top top_left top_right right left bottom), fn position ->
        assigns = Map.put(assigns, :position, position)

        markup = ~H"""
        <.badge position={@position}>
          Emails
          <:badge>99+</:badge>
        </.badge>
        """

        html = rendered_to_string(markup)

        if String.contains?(position, "top") do
          assert html =~ "top-0 -translate-y-1/2"
        end

        if String.contains?(position, "right") do
          assert html =~ "right-0 translate-x-1/2"
        end

        if String.contains?(position, "bottom") do
          assert html =~ "bottom-0 translate-y-1/2"
        end

        if String.contains?(position, "left") do
          assert html =~ "left-0 -translate-x-1/2"
        end
      end)
    end

    test "should render with extended classes", %{assigns: assigns} do
      markup = ~H"""
      <.badge class="extended-class">
        Emails
        <:badge>99+</:badge>
      </.badge>
      """

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert hd(Floki.attribute(doc, "div.badge-wrapper", "class")) =~ "extended-class"
    end

    test "should render with set `:rest` attribute", %{assigns: assigns} do
      markup = ~H"""
      <.badge data-test="abc">
        Emails
        <:badge>99+</:badge>
      </.badge>
      """

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert Floki.attribute(doc, "div.badge-wrapper", "data-test") == ["abc"]
    end
  end
end
