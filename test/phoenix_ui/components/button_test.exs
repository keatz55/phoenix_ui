defmodule Phoenix.UI.Components.ButtonTest do
  import ExUnit.CaptureIO

  use Phoenix.UI.Case, async: true

  @moduletag :after_verify

  setup do
    [assigns: %{text: "text"}]
  end

  test "should render with defaults", %{assigns: assigns} do
    markup = ~H[<.button type="button"><%= @text %></.button>]
    html = rendered_to_string(markup)
    assert html =~ "<button class=\"button "
    assert html =~ "type=\"button\">"
    assert html =~ assigns.text
    assert html =~ "</button>"
  end

  test "should render link when passed `href` attr", %{assigns: assigns} do
    markup = ~H[<.button href="/"><%= @text %></.button>]
    rendered_to_string(markup) =~ "<a href=\"/\""
  end

  test "should render link when passed `navigate` attr", %{assigns: assigns} do
    markup = ~H[<.button navigate="/"><%= @text %></.button>]
    rendered_to_string(markup) =~ "<a href=\"/\" data-phx-link=\"patch\""
  end

  test "should render link when passed `patch` attr", %{assigns: assigns} do
    markup = ~H[<.button patch="/"><%= @text %></.button>]
    rendered_to_string(markup) =~ "a href=\"/\" data-phx-link=\"patch\""
  end

  test "should render button that is full width of container", %{assigns: assigns} do
    markup = ~H[<.button full_width><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "w-full"
  end

  test "should render button that is not full width of container", %{assigns: assigns} do
    markup = ~H[<.button full_width={false}><%= @text %></.button>]
    refute rendered_to_string(markup) =~ "w-full"
  end

  test "should render button with rounded corners", %{assigns: assigns} do
    markup = ~H[<.button><%= @text %></.button>]
    html = rendered_to_string(markup)
    assert html =~ "rounded"
    refute html =~ "rounded-full"
  end

  test "should render circular button when icon variant", %{assigns: assigns} do
    markup = ~H[<.button variant="icon"><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "rounded-full"
  end

  test "should render button without rounded corners", %{assigns: assigns} do
    markup = ~H[<.button square><%= @text %></.button>]
    refute rendered_to_string(markup) =~ "rounded"
  end

  test "should render button with passed HTML element override", %{assigns: assigns} do
    markup = ~H[<.button element="div"><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "<div class=\"button"
  end

  test "should render button with \"xs\" size", %{assigns: assigns} do
    markup = ~H[<.button size="xs"><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "py-1 px-1.5 text-xs"
  end

  test "should render button with \"sm\" size", %{assigns: assigns} do
    markup = ~H[<.button size="sm"><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "py-2 px-3 text-xs"
  end

  test "should render button with \"md\" size", %{assigns: assigns} do
    markup = ~H[<.button size="md"><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "py-2 px-4 text-base font-semibold"
  end

  test "should render button with \"lg\" size", %{assigns: assigns} do
    markup = ~H[<.button size="lg"><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "py-3 px-5 text-xl font-bold"
  end

  test "should render override color when passed color attr", %{assigns: assigns} do
    markup = ~H[<.button color="yellow"><%= @text %></.button>]
    assert rendered_to_string(markup) =~ "yellow"
  end

  test "warns when unknown attributes passed to button", %{assigns: assigns} do
    warnings =
      capture_io(:stderr, fn ->
        defmodule UndefinedAttrs do
          use Phoenix.Component

          def render(assigns) do
            ~H"""
            <.button color="undefined" size="undefined" variant="undefined">
              <%= @text %>
            </.button>
            """
          end
        end
      end)

    assert warnings =~
             "attribute \"color\" in component Phoenix.UI.Components.Button.button/1 must be one of"

    assert warnings =~
             "attribute \"size\" in component Phoenix.UI.Components.Button.button/1 must be one of"

    assert warnings =~
             "attribute \"variant\" in component Phoenix.UI.Components.Button.button/1 must be one of"
  end
end
