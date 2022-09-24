defmodule PhoenixUI.Components.LinkTest do
  alias PhoenixUI.Components.Link

  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{text: "text"}]
  end

  describe "link/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.a>
        <%= @text %>
      </.a>
      """

      html = rendered_to_string(markup)

      assert html =~ "<a "
      assert html =~ "class=\"link "
      assert html =~ assigns.text
      assert html =~ "</a>"
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = Link.classes()
    end
  end
end
