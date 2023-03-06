defmodule Phoenix.UI.Components.ProgressTest do
  import ExUnit.CaptureIO

  use Phoenix.UI.Case, async: true

  setup do
    [assigns: %{}]
  end

  test "should render with default radial variant", %{assigns: assigns} do
    markup = ~H[<.progress />]
    html = rendered_to_string(markup)
    assert html =~ "<svg aria-hidden=\"true\" class=\"progress "
    assert html =~ "h-12 w-12 text-blue-500"
    assert html =~ "stroke-dasharray=\"30, 100\""
    assert html =~ "stroke-linecap=\"round\""
    refute html =~ "<text"
  end

  test "should render linear progress variant", %{assigns: assigns} do
    markup = ~H[<.progress variant="linear" />]
    html = rendered_to_string(markup)
    assert html =~ "<div class=\"progress w-full "
    assert html =~ "h-5 bg-gray-200 dark:bg-gray-700"
    assert html =~ "h-5 bg-blue-500 text-blue-100"
    assert html =~ "style=\"width: 30%\""
    refute html =~ "<span"
  end

  test "should render radial progress with set size", %{assigns: assigns} do
    markup = ~H[<.progress size="10" />]
    assert rendered_to_string(markup) =~ "h-10 w-10"
  end

  test "should render linear progress with set size", %{assigns: assigns} do
    markup = ~H[<.progress variant="linear" size="10" />]
    assert rendered_to_string(markup) =~ "h-10"
  end

  test "should render radial progress with set color", %{assigns: assigns} do
    markup = ~H[<.progress color="orange" />]
    assert rendered_to_string(markup) =~ "text-orange-500"
  end

  test "should render linear progress with set color", %{assigns: assigns} do
    markup = ~H[<.progress variant="linear" color="orange" />]
    assert rendered_to_string(markup) =~ "bg-orange-500"
  end

  test "should render radial progress with square corners", %{assigns: assigns} do
    markup = ~H[<.progress square />]
    refute rendered_to_string(markup) =~ "stroke-linecap=\"round\""
  end

  test "should render linear progress with square corners", %{assigns: assigns} do
    markup = ~H[<.progress variant="linear" square />]
    refute rendered_to_string(markup) =~ "rounded-full"
  end

  test "should render radial progress with set value", %{assigns: assigns} do
    markup = ~H[<.progress value={100} />]
    assert rendered_to_string(markup) =~ "stroke-dasharray=\"100, 100\""
  end

  test "should render linear progress with set value", %{assigns: assigns} do
    markup = ~H[<.progress variant="linear" value={100} />]
    assert rendered_to_string(markup) =~ "style=\"width: 100%\""
  end

  test "should render radial progress with set text", %{assigns: assigns} do
    markup = ~H[<.progress text="30%" />]
    html = rendered_to_string(markup)
    assert html =~ "<text"
    assert html =~ "30%"
  end

  test "should render linear progress with set text", %{assigns: assigns} do
    markup = ~H[<.progress variant="linear" text="30%" />]
    assert rendered_to_string(markup) =~ "<span>30%</span>"
  end

  test "should render radial progress with extended class", %{assigns: assigns} do
    markup = ~H[<.progress extend_class="extended" />]
    assert rendered_to_string(markup) =~ " extended\""
  end

  test "should render linear progress with extended class", %{assigns: assigns} do
    markup = ~H[<.progress variant="linear" extend_class="extended" />]
    assert rendered_to_string(markup) =~ " extended\""
  end

  test "warns when unknown attributes passed to button", %{assigns: assigns} do
    warnings =
      capture_io(:stderr, fn ->
        defmodule UndefinedAttrs do
          use Phoenix.Component

          def render(assigns) do
            ~H"""
            <.progress color="undefined" variant="undefined">
              <%= @text %>
            </.progress>
            """
          end
        end
      end)

    assert warnings =~
             "attribute \"color\" in component Phoenix.UI.Components.Progress.progress/1 must be one of"

    assert warnings =~
             "attribute \"variant\" in component Phoenix.UI.Components.Progress.progress/1 must be one of"
  end
end
