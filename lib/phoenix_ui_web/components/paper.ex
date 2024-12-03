defmodule PhoenixUIWeb.Components.Paper do
  @moduledoc """
  Provides paper-related components.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  @doc """
  The Paper component is a container for displaying content on an elevated surface.

  ## Examples

  ```heex
  <.paper>
    content
  </.paper>
  ```
  """

  attr :blur, :boolean, default: true
  attr :class, :any
  attr :element, :string, default: "div"
  attr :elevation, :integer, default: 2, values: 1..5
  attr :rest, :global
  attr :square, :boolean, default: false

  slot :inner_block, required: true

  @spec paper(Socket.assigns()) :: Rendered.t()
  def paper(assigns) do
    ~H"""
    <.dynamic_tag
      class={
        [
          "paper isolate w-max overflow-y-auto transition-all ease-in duration-100",
          # Invisible border that is only visible in `forced-colors` mode for accessibility purposes
          "outline outline-1 outline-transparent focus:outline-none",
          # Background
          "bg-white/75 dark:bg-zinc-800/75",
          # Shadows
          "ring-1 ring-zinc-950/10 dark:ring-inset dark:ring-white/10",
          styles(:blur, assigns),
          styles(:elevation, assigns),
          styles(:square, assigns),
          assigns[:class]
        ]
      }
      tag_name={@element}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### Styles ##########################

  # Blur
  defp styles(:blur, %{blur: true}), do: "backdrop-blur-xl"

  # Elevation
  defp styles(:elevation, %{variant: "outline"}), do: nil
  defp styles(:elevation, %{elevation: 0}), do: "shadow-none"
  defp styles(:elevation, %{elevation: 1}), do: "shadow-sm"
  defp styles(:elevation, %{elevation: 2}), do: "shadow-md"
  defp styles(:elevation, %{elevation: 3}), do: "shadow-lg"
  defp styles(:elevation, %{elevation: 4}), do: "shadow-xl"
  defp styles(:elevation, %{elevation: 5}), do: "shadow-2xl"

  # Square
  defp styles(:square, %{square: false}), do: "rounded-xl"

  defp styles(_rule_group, _assigns), do: nil
end
