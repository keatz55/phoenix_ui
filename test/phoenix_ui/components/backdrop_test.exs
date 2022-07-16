defmodule PhoenixUI.Components.BackdropTest do
  alias PhoenixUI.Components.Backdrop

  use PhoenixUI.Case, async: true

  setup do
    [assigns: %{}]
  end

  describe "backdrop/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.backdrop id="basic-backdrop" />
      """

      html = rendered_to_string(markup)

      assert html =~ "<div class=\"backdrop "
    end
  end

  describe "classes/0" do
    test "should generate a list of all possible classes for Tailwind CSS JIT compiler" do
      assert [_ | _] = Backdrop.classes()
    end
  end
end
