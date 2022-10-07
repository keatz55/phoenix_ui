defmodule Phoenix.UI.Components.FormGroup do
  @moduledoc """
  Provides form group component.
  """
  use Phoenix.UI, :component

  attr(:element, :string, default: "div")
  attr(:margin, :boolean, default: true)

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
  def form_group(prev_assigns) do
    assigns = build_form_group_attrs(prev_assigns)

    ~H"""
    <.dynamic_tag {@form_group_attrs}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
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
      |> Keyword.put(:name, assigns[:element])

    assign(assigns, :form_group_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Margin
  defp classes(:margin, %{margin: true}), do: "mb-3"

  defp classes(_rule_group, _assigns), do: nil
end
