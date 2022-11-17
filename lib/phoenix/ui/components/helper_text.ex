defmodule Phoenix.UI.Components.HelperText do
  @moduledoc """
  Provides helper text component.
  """
  use Phoenix.UI, :component

  attr(:class, :string, doc: "Override the classes applied to the component.")
  attr(:element, :string, default: "div", doc: "The HTML element to use, such as `div`.")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")
  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Renders helper text component.

  ## Examples

      <.helper_text>
        We'll never share your email with anyone else.
      </.helper_text>

  """
  @spec helper_text(Socket.assigns()) :: Rendered.t()
  def helper_text(assigns) do
    assigns = assign_class(assigns, ~w(
      mt-2 text-sm text-slate-500 dark:text-slate-400 disabled:text-slate-400 dark:disabled:text-slate-500
      invalid:hidden
    ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end
end
