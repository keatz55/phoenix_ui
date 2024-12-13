defmodule PhoenixUIWeb.Components.BreadcrumbTest do
  use PhoenixUIWeb.ConnCase, async: true

  import PhoenixUIWeb.Components.Breadcrumb

  setup do
    [assigns: %{}]
  end

  describe "breadcrumb/1" do
    test "should render with defaults", %{assigns: assigns} do
      markup = ~H"""
      <.breadcrumb id="basic-breadcrumb">
        <:item>Phoenix UI</:item>
        <:item>Core</:item>
        <:item aria-current="page">Breadcrumbs</:item>
      </.breadcrumb>
      """

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert Floki.attribute(doc, "nav", "aria-label") == ["Breadcrumb"]
      assert Floki.attribute(doc, "nav", "id") == ["basic-breadcrumb"]
      assert hd(Floki.attribute(doc, "nav", "class")) =~ "breadcrumb "

      assert Floki.attribute(doc, "ol", "role") == ["list"]

      assert doc |> Floki.find("[aria-current=page]") |> Floki.text() =~ "Breadcrumbs"
    end

    test "should render with set separator_icon value", %{assigns: assigns} do
      markup = ~H"""
      <.breadcrumb separator_icon="hero-cake">
        <:item>Phoenix UI</:item>
        <:item>Core</:item>
        <:item aria-current="page">Breadcrumbs</:item>
      </.breadcrumb>
      """

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert hd(Floki.attribute(doc, "span.icon", "class")) =~ "hero-cake"
    end

    test "should render with extended classes", %{assigns: assigns} do
      markup = ~H"""
      <.breadcrumb class="extended-class">
        <:item>Phoenix UI</:item>
        <:item>Core</:item>
        <:item aria-current="page">Breadcrumbs</:item>
      </.breadcrumb>
      """

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert hd(Floki.attribute(doc, "nav", "class")) =~ "extended-class"
    end

    test "should render with set `:rest` attribute", %{assigns: assigns} do
      markup = ~H"""
      <.breadcrumb data-test="abc">
        <:item>Phoenix UI</:item>
        <:item>Core</:item>
        <:item aria-current="page">Breadcrumbs</:item>
      </.breadcrumb>
      """

      assert {:ok, doc} = markup |> rendered_to_string() |> Floki.parse_document()

      assert Floki.attribute(doc, "nav", "data-test") == ["abc"]
    end
  end
end
