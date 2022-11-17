defmodule Phoenix.UI.Components.Label do
  @moduledoc """
  Provides label component.
  """
  use Phoenix.UI, :component

  attr(:for, :string, default: nil)
  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")

  slot(:inner_block, required: true)

  @doc """
  Renders label component.

  ## Examples

      <.label for={@id}>
        Name
      </.label>

  """
  @spec label(Socket.assigns()) :: Rendered.t()
  def label(assigns) do
    assigns = assign_class(assigns, ~w(
      label flex items-center mb-2 text-slate-600 dark:text-slate-300
      disabled:text-slate-500 dark:disabled:text-slate-400 invalid:text-red-500
    ))

    ~H"""
    <label class={@class} for={@for} {@rest}>
      <%= render_slot(@inner_block) %>
    </label>
    """
  end
end
