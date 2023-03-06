defmodule Phoenix.UI.Components.TextFieldTest do
  import ExUnit.CaptureIO

  use Phoenix.UI.Case, async: true

  setup do
    [assigns: %{}]
  end

  test "should render input with defaults", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "<input class=\"input "
    assert html =~ "id=\"user_email\""
    assert html =~ "name=\"user[email]\""
    assert html =~ "phx-debounce=\"blur\""
    assert html =~ "type=\"text\""
  end

  test "should render input \"password\" type", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} type="password" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "type=\"password\""
  end

  test "should render input that is full width of container", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} full_width />
    </.form>
    """

    assert rendered_to_string(markup) =~ "w-full"
  end

  test "should render input that is not full width of container", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} />
    </.form>
    """

    refute rendered_to_string(markup) =~ "w-full"
  end

  test "should render input with class override", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} class="override" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "class=\"override\""
  end

  test "should render input class w/ extend_class", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} extend_class="extension" />
    </.form>
    """

    assert rendered_to_string(markup) =~ " extension\""
  end

  test "should render input with placeholder", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} placeholder="Email" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "placeholder=\"Email\""
  end

  test "should render input with phx-debounce override", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} phx-debounce={300} />
    </.form>
    """

    assert rendered_to_string(markup) =~ "phx-debounce=\"300\""
  end

  test "should render input with value", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} value="Value" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "value=\"Value\""
  end

  test "should render input with \"none\" margin", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} margin="none" />
    </.form>
    """

    assert rendered_to_string(markup) =~ "<div class=\"form-group\""
  end

  test "should render input with start icon", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} start_icon={%{name: "currency-dollar"}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"start-icon "
    assert html =~ "<svg class=\"heroicon "
  end

  test "should render input with end icon", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} end_icon={%{name: "x-mark"}} />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"end-icon "
    assert html =~ "<svg class=\"heroicon "
  end

  test "should render input with label and helper_text", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field field={{f, :email}} helper_text="Helper text" label="Email Label" />
    </.form>
    """

    html = rendered_to_string(markup)
    assert html =~ "class=\"label"
    assert html =~ "Email Label"
    assert html =~ "class=\"helper-text invalid:hidden"
    assert html =~ "Helper text"
    refute html =~ "error-tag"
  end

  test "should render input with errors", %{assigns: assigns} do
    markup = ~H"""
    <.form :let={f} for={%{}} as={:user}>
      <.text_field errors={["required"]} field={{f, :email}} />
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
              <.text_field field={{f, :email}} margin="undefined" variant="undefined" />
            </.form>
            """
          end
        end
      end)

    assert warnings =~
             "attribute \"margin\" in component Phoenix.UI.Components.TextField.text_field/1 must be one of"

    assert warnings =~
             "attribute \"variant\" in component Phoenix.UI.Components.TextField.text_field/1 must be one of"
  end
end
