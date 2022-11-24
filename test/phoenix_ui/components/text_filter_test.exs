defmodule Phoenix.UI.Components.TextFilterTest do
  use Phoenix.UI.Case, async: true

  test "should render TextFilter w/ dynamic URI filtering" do
    html = render_component(TextFilter, id: "filter", param: "name", uri: URI.new("/"))

    assert html =~ "<form id=\"filter_form\""
    assert html =~ "phx-change=\"handle_change\""
    assert html =~ "phx-submit=\"handle_change\""
    assert html =~ "<svg class=\"heroicon"
  end

  test "should render TextFilter w/ on_change anonymous fun filtering" do
    html = render_component(TextFilter, id: "filter", on_change: fn _value, socket -> socket end)

    assert html =~ "phx-change=\"handle_change\""
    assert html =~ "phx-submit=\"handle_change\""
  end

  test "should render TextFilter w/ parent-specific form events" do
    html = render_component(TextFilter, on_change: "custom_parent_event", id: "filter")

    assert html =~ "phx-change=\"custom_parent_event\""
    assert html =~ "phx-submit=\"custom_parent_event\""
    refute html =~ "phx-target"
  end

  test "should render TextFilter w/ default value" do
    html = render_component(TextFilter, id: "filter", value: "Default Value")

    assert html =~ "value=\"Default Value\""
  end

  test "should render TextFilter w/ placeholder" do
    html = render_component(TextFilter, id: "filter", placeholder: "Filter by name...")

    assert html =~ "placeholder=\"Filter by name...\""
  end

  test "should render TextFilter w/ full_width=false" do
    html = render_component(TextFilter, id: "filter", full_width: false)

    refute html =~ "w-full"
  end
end
