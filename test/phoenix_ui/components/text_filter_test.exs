defmodule Phoenix.UI.Components.TextFilterTest do
  use Phoenix.UI.Case, async: true

  test "should render text input filter component" do
    html =
      render_component(TextFilter,
        id: "name_filter",
        on_change: fn _value, socket -> socket end,
        placeholder: "Filter by name...",
        value: "Default Value"
      )

    assert html =~ "<form id=\"name_filter_form\""
    assert html =~ "phx-change=\"handle_change\""
    assert html =~ "phx-submit=\"handle_change\""
    assert html =~ "<svg class=\"heroicon"
    assert html =~ "placeholder=\"Filter by name...\""
    assert html =~ "value=\"Default Value\""
  end

  test "should override live component form events" do
    html =
      render_component(TextFilter,
        "phx-change": "custom_event",
        "phx-submit": "custom_event",
        "phx-target": 1,
        id: "name_filter"
      )

    assert html =~ "<form id=\"name_filter_form\""
    assert html =~ "phx-change=\"custom_event\""
    assert html =~ "phx-submit=\"custom_event\""
    assert html =~ "phx-target=\"1\""
  end
end
