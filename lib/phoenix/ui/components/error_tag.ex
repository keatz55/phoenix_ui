defmodule Phoenix.UI.Components.ErrorTag do
  @moduledoc """
  Provides error tag component.
  """
  use Phoenix.UI, :component

  attr(:class, :string, doc: "Override the classes applied to the component.")
  attr(:element, :string, default: "p")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Renders error tag component.

  ## Examples

      <.error_tag>
        <%= @error %>
      </.error_tag>

  """
  @spec error_tag(Socket.assigns()) :: Rendered.t()
  def error_tag(assigns) do
    assigns = assign_class(assigns, ~w(
      error-tag hidden invalid:block mt-2 text-sm text-red-500
    ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end
end
