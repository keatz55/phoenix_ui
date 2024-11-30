defmodule PhoenixUIWeb.Components.AccordionTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Accordion

  setup do
    [assigns: %{}]
  end

  describe "accordion/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.accordion id="basic_accordion">
        <:trigger>
          Trigger
        </:trigger>
        <:panel>
          Panel
        </:panel>
      </.accordion>
      """

      html = rendered_to_string(markup)

      assert html =~ ~s(<div class="accordion ")

      assert html =~
               ~s(<button aria-controls="basic_accordion_panel0" aria-expanded="false" class="accordion-trigger)

      assert html =~ "Trigger"
      assert html =~ ~s(<div class="accordion-panel )
      assert html =~ "Panel"
      refute html =~ " data-expanded"
    end
  end

  test "should render with panel expanded by default", %{assigns: assigns} do
    markup = ~H"""
    <.accordion id="basic_accordion">
      <:trigger>
        Trigger
      </:trigger>
      <:panel default_expanded>
        Panel
      </:panel>
    </.accordion>
    """

    html = rendered_to_string(markup)

    assert html =~ ~s(<div class="accordion ")

    assert html =~
             ~s(<button aria-controls="basic_accordion_panel0" aria-expanded="false" class="accordion-trigger)

    assert html =~ "Trigger"
    assert html =~ ~s(<div class="accordion-panel )
    assert html =~ "Panel"
    assert html =~ " data-expanded"
  end
end
