defmodule PhoenixUI.Components.ButtonTest do
  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{text: "text"}]
  end

  describe "button/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.button>
        <%= @text %>
      </.button>
      """

      html = rendered_to_string(markup)

      assert html =~ "<button class=\"button "
      assert html =~ "type=\"button\">"
      assert html =~ assigns.text
      assert html =~ "</button>"
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = PhoenixUI.Components.Button.classes()
    end
  end
end
