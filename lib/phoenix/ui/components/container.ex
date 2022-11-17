defmodule Phoenix.UI.Components.Container do
  @moduledoc """
  Provides container component.
  """
  use Phoenix.UI, :component

  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:max_width, :string, default: "screen-lg")
  attr(:rest, :global)
  attr(:variant, :string, default: "fluid", values: ["fixed", "fluid"])

  slot(:inner_block, required: true)

  @doc """
  Renders container component.

  ## Examples

      ```
      <.container>
        Content
      </.container>
      ```

  """
  @spec container(Socket.assigns()) :: Rendered.t()
  def container(assigns) do
    assigns = assign_class(assigns, ~w(
        container mx-auto
        #{classes(:max_width, assigns)}
        #{classes(:variant, assigns)}
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### CSS Classes ##########################

  # Max Width
  defp classes(:max_width, %{max_width: max_width}), do: "max-w-#{max_width}"

  # Variant
  defp classes(:variant, %{variant: "fixed"}), do: "fixed"
  defp classes(:variant, %{variant: "fluid"}), do: "relative"

  defp classes(_rule_group, _assigns), do: "relative"
end
