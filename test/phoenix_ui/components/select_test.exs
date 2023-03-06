defmodule Phoenix.UI.Components.SelectTest do
  import ExUnit.CaptureIO

  use Phoenix.UI.Case, async: true

  setup do
    options = ["cat", "dog", "goldfish", "hamster", "parrot", "spider"]

    [assigns: %{options: options}]
  end

  test "should render select with defaults", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "<select class=\"select "
    assert html =~ "id=\"user_pet\""
    assert html =~ "name=\"user[pet]\""
    assert html =~ "phx-debounce=\"blur\""
  end

  test "should render select that is full width of container", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} full_width />
    </.form>
    """

    assert rendered_to_string(markup) =~ "w-full"
  end

  test "should render select that is not full width of container", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} />
    </.form>
    """

    refute rendered_to_string(markup) =~ "w-full"
  end

  test "should render select with class override", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} class="override" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "class=\"override\""
  end

  test "should render select class w/ extend_class", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} extend_class="extension" />
    </.form>
    """

    assert rendered_to_string(markup) =~ " extension\""
  end

  test "should render select with phx-debounce override", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} phx-debounce={300} />
    </.form>
    """

    assert rendered_to_string(markup) =~ "phx-debounce=\"300\""
  end

  test "should render select with value", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} value="dog" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "<option selected value=\"dog\">dog</option>"
  end

  test "should render select with \"none\" margin", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} margin="none" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "<div class=\"form-group\""
  end

  test "should render select with start icon", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} start_icon={%{name: "currency-dollar"}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"start-icon "
    assert html =~ "<svg class=\"heroicon "
  end

  test "should render select with end icon", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} end_icon={%{name: "x-mark"}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"end-icon "
    assert html =~ "<svg class=\"heroicon "
  end

  test "should render select with label and helper_text", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select field={{f, :pet}} options={@options} helper_text="Helper text" label="Pet Label" />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"label"
    assert html =~ "Pet Label"
    assert html =~ "class=\"helper-text invalid:hidden"
    assert html =~ "Helper text"
    refute html =~ "error-tag"
  end

  test "should render select with errors", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.select errors={["required"]} field={{f, :pet}} options={@options} />
    </.form>
    """

    assert rendered_to_string(markup) =~ "class=\"error-tag hidden invalid:block "
  end

  test "warns when unknown attributes passed to button", %{assigns: assigns} do
    warnings =
      capture_io(:stderr, fn ->
        defmodule UndefinedAttrs do
          use Phoenix.Component

          def render(assigns) do
            ~H"""
            <.form :let={f} for={%{}} as={:user}>
              <.select field={{f, :pet}} options={@options} margin="undefined" variant="undefined" />
            </.form>
            """
          end
        end
      end)

    assert warnings =~
             "attribute \"margin\" in component Phoenix.UI.Components.Select.select/1 must be one of"

    assert warnings =~
             "attribute \"variant\" in component Phoenix.UI.Components.Select.select/1 must be one of"
  end
end
