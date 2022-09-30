defmodule Phoenix.UI.Components.AccordionTest do
  use Phoenix.UI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "accordion/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.accordion id="basic_accordion">
        <:header>
          Header
        </:header>
        <:panel>
          Content
        </:panel>
      </.accordion>
      """

      html = rendered_to_string(markup)

      assert html =~ "<div class=\"accordion\""
      assert html =~ "<div class=\"accordion-header closed"
      assert html =~ "Header"
      assert html =~ "<div class=\"collapse"
      assert html =~ "Content"
    end
  end
end
