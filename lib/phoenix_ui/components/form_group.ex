defmodule PhoenixUI.Components.FormGroup do
  @moduledoc """
  Provides form group component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_element "div"
  @default_margin true

  @doc """
  Renders form group component.

  ## Examples

      ```
      <.form_group>
        <.label field={:name} form={f}>
          Name
        </.label>
        <.text_input
          field={:name}
          form={f}
        />
      </.form_group>
      ```

  """
  @spec form_group(Socket.assigns()) :: Rendered.t()
  def form_group(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:element, fn -> @default_element end)
      |> assign_new(:margin, fn -> @default_margin end)
      |> build_form_group_attrs()

    ~H"""
    <.element {@form_group_attrs}>
      <%= render_slot(@inner_block) %>
    </.element>
    """
  end

  ### Form Group Attrs ##########################

  defp build_form_group_attrs(assigns) do
    class = build_class(~w(
      form-group
      #{classes(:margin, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:element, :extend_class, :margin])
      |> Keyword.put_new(:class, class)
      |> Keyword.put(:variant, assigns[:element])

    assign(assigns, :form_group_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Margin
  defp classes(:margin, %{margin: true}), do: "mb-3"

  defp classes(_rule_group, _assigns), do: nil
end
