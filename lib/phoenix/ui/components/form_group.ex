defmodule Phoenix.UI.Components.FormGroup do
  @moduledoc """
  Provides form group component.
  """
  use Phoenix.UI, :component

  attr(:class, :string, doc: "Override the classes applied to the component.")
  attr(:element, :string, default: "div", doc: "The HTML element to use, such as `div`.")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:invalid, :boolean, default: false)

  attr(:margin, :string,
    default: "normal",
    doc: "If dense or normal, will adjust vertical spacing of this and contained components.",
    values: ["dense", "none", "normal"]
  )

  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Renders form group component.

  ## Examples

      <.form_group>
        <.label field={:name} form={f}>
          Name
        </.label>
        <.text_input
          field={:name}
          form={f}
        />
      </.form_group>

  """
  @spec form_group(Socket.assigns()) :: Rendered.t()
  def form_group(assigns) do
    assigns = assign_class(assigns, ~w(
      form-group
      #{classes(:margin, assigns)}
      #{classes(:invalid, assigns)}
    ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### CSS Classes ##########################

  # Margin
  defp classes(:margin, %{margin: "normal"}), do: "mt-2 mb-4"
  defp classes(:margin, %{margin: "dense"}), do: "mt-1 mb-2"

  # Invalid
  defp classes(:invalid, %{invalid: true}), do: "invalid"

  defp classes(_rule_group, _assigns), do: nil
end
