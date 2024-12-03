defmodule PhoenixUIWeb.Components.ButtonTest do
  use PhoenixUIWeb.ConnCase, async: true

  import ExUnit.CaptureIO
  import PhoenixUIWeb.Components.Button

  setup do
    [assigns: %{text: "text"}]
  end

  test "should render with defaults", %{assigns: assigns} do
    markup = ~H(<.button type="button"><%= @text %></.button>)
    html = rendered_to_string(markup)
    assert html =~ ~s(<button )
    assert html =~ ~s(type="button")
    assert html =~ ~s(class="button )
    assert html =~ "blue"
    assert html =~ "rounded-lg"
    assert html =~ assigns.text
    assert html =~ "</button>"
    refute html =~ "w-full"
  end

  test "should render button variants", %{assigns: assigns} do
    for variant <- ~w(plain solid outline)a do
      assigns = Map.put(assigns, :variant, variant)
      markup = ~H(<.button variant={@variant}><%= @text %></.button>)
      assert rendered_to_string(markup) =~ "button-#{variant}"
    end
  end

  test "should render button that is full width of container", %{assigns: assigns} do
    markup = ~H(<.button full_width><%= @text %></.button>)
    assert rendered_to_string(markup) =~ "w-full"
  end

  test "should render button with square corners", %{assigns: assigns} do
    markup = ~H(<.button square><%= @text %></.button>)
    html = rendered_to_string(markup)
    refute html =~ "rounded-lg"
  end

  test "should render button with passed HTML element override", %{assigns: assigns} do
    markup = ~H(<.button element="label"><%= @text %></.button>)
    assert rendered_to_string(markup) =~ ~s(<label class="button)
  end

  test "should render button with sizes", %{assigns: assigns} do
    m1 = ~H(<.button size="xs"><%= @text %></.button>)
    m2 = ~H(<.button size="sm"><%= @text %></.button>)
    m3 = ~H(<.button size="md"><%= @text %></.button>)
    m4 = ~H(<.button size="lg"><%= @text %></.button>)

    assert rendered_to_string(m1) =~ "px-1.5"
    assert rendered_to_string(m2) =~ "px-3"
    assert rendered_to_string(m3) =~ "px-3.5"
    assert rendered_to_string(m4) =~ "px-5"
  end

  test "should render override color when passed color attr", %{assigns: assigns} do
    markup = ~H(<.button color="red" variant="outline"><%= @text %></.button>)
    assert rendered_to_string(markup) =~ "red"
  end

  test "warns when unknown attributes passed to button", %{assigns: assigns} do
    warnings =
      capture_io(:stderr, fn ->
        defmodule UndefinedAttrs do
          use Phoenix.Component

          def render(assigns) do
            ~H(<.button variant="undefined"><%= @text %></.button>)
          end
        end
      end)

    assert warnings =~
             ~s(attribute "variant" in component PhoenixUIWeb.Components.Button.button/1 must be one of ["plain", "outline", "solid"], got: "undefined")
  end
end
