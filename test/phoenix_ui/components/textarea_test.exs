defmodule Phoenix.UI.Components.TextareaTest do
  import ExUnit.CaptureIO

  use Phoenix.UI.Case, async: true

  setup do
    [assigns: %{}]
  end

  test "should render textarea with defaults", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "<textarea class=\"textarea "
    assert html =~ "id=\"user_description\""
    assert html =~ "name=\"user[description]\""
    assert html =~ "phx-debounce=\"blur\""
  end

  test "should render textarea w/ 10 rows", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} rows="10" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "rows=\"10\""
  end

  test "should render textarea that is full width of container", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} full_width />
    </.form>
    """

    assert rendered_to_string(markup) =~ "w-full"
  end

  test "should render textarea that is not full width of container", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} />
    </.form>
    """

    refute rendered_to_string(markup) =~ "w-full"
  end

  test "should render textarea with class override", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} class="override" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "class=\"override\""
  end

  test "should render textarea class w/ extend_class", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} extend_class="resize-none" />
    </.form>
    """

    assert rendered_to_string(markup) =~ " resize-none\""
  end

  test "should render textarea with placeholder", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} placeholder="Description" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "placeholder=\"Description\""
  end

  test "should render textarea with phx-debounce override", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} phx-debounce={300} />
    </.form>
    """

    assert rendered_to_string(markup) =~ "phx-debounce=\"300\""
  end

  test "should render textarea with value", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} value="Value" />
    </.form>
    """

    assert rendered_to_string(markup) =~ ">Value</textarea>"
  end

  test "should render textarea with \"none\" margin", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} margin="none" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "<div class=\"form-control\""
  end

  test "should render textarea with start icon", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} start_icon={%{name: "currency-dollar"}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"start-icon "
    assert html =~ "<svg class=\"heroicon "
  end

  test "should render textarea with end icon", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} end_icon={%{name: "x-mark"}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"end-icon "
    assert html =~ "<svg class=\"heroicon "
  end

  test "should render textarea with label and helper_text", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea field={{f, :description}} helper_text="Helper text" label="Description Label" />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"label"
    assert html =~ "Description Label"
    assert html =~ "class=\"helper-text invalid:hidden"
    assert html =~ "Helper text"
    refute html =~ "error"
  end

  test "should render textarea with errors", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={:user}>
      <.textarea errors={["required"]} field={{f, :description}} />
    </.form>
    """

    assert rendered_to_string(markup) =~ "class=\"error hidden invalid:block "
  end

  test "warns when unknown attributes passed to button", %{assigns: assigns} do
    warnings =
      capture_io(:stderr, fn ->
        defmodule UndefinedAttrs do
          use Phoenix.Component

          def render(assigns) do
            ~H"""
            <.form :let={f} for={:user}>
              <.textarea field={{f, :description}} margin="undefined" variant="undefined" />
            </.form>
            """
          end
        end
      end)

    assert warnings =~
             "attribute \"margin\" in component Phoenix.UI.Components.Form.textarea/1 must be one of"

    assert warnings =~
             "attribute \"variant\" in component Phoenix.UI.Components.Form.textarea/1 must be one of"
  end
end
