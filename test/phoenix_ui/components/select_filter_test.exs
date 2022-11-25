defmodule Phoenix.UI.Components.SelectFilterTest do
  use Phoenix.UI.Case, async: true

  test "should render SelectFilter w/ dynamic URI filtering" do
    html =
      render_component(SelectFilter, id: "filter", param: "role", uri: URI.new("/"), options: [])

    assert html =~ "<form id=\"filter_form\""
    assert html =~ "phx-change=\"handle_change\""
    assert html =~ "phx-submit=\"handle_change\""
  end

  test "should render SelectFilter w/ on_change anonymous fun filtering" do
    html =
      render_component(SelectFilter,
        id: "filter",
        on_change: fn _value, socket -> socket end,
        options: []
      )

    assert html =~ "phx-change=\"handle_change\""
    assert html =~ "phx-submit=\"handle_change\""
  end

  test "should render SelectFilter w/ parent-specific form events" do
    html =
      render_component(SelectFilter, on_change: "custom_parent_event", id: "filter", options: [])

    assert html =~ "phx-change=\"custom_parent_event\""
    assert html =~ "phx-submit=\"custom_parent_event\""
    refute html =~ "phx-target"
  end

  test "should render SelectFilter w/ default value" do
    html = render_component(SelectFilter, id: "filter", value: "user", options: ["user"])

    assert html =~ "<option selected value=\"user\">user</option>"
  end

  test "should render SelectFilter w/ placeholder" do
    html = render_component(SelectFilter, id: "filter", options: [], prompt: "Select role")

    assert html =~ "<option value>Select role</option>"
  end

  test "should render SelectFilter w/ full_width=false" do
    html = render_component(SelectFilter, id: "filter", full_width: false, options: [])

    refute html =~ "w-full"
  end
end
