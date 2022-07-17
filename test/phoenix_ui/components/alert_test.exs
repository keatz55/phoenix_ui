defmodule PhoenixUI.Components.AlertTest do
  alias PhoenixUI.Components.Alert

  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "alert/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.alert>
        Content
      </.alert>
      """

      html = rendered_to_string(markup)

      assert html =~ "<div role=\"alert\" class=\"alert "
      assert html =~ "<svg class=\"heroicon "
      assert html =~ "Content"
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = Alert.classes()
    end
  end
end
