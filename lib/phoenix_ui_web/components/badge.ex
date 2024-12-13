defmodule PhoenixUIWeb.Components.Badge do
  @moduledoc """
  Provides badge-related components.
  """
  use PhoenixUIWeb, :component

  @doc """
  Badge generates a small badge to the top-right of its child(ren).

  ## Examples

   ```heex
  <.badge>
    Emails
    <:badge>99+</:badge>
  </.badge>
  ```
  """
  attr :border, :boolean, default: false
  attr :class, :any, doc: "Extend existing component styles"
  attr :color, :string, default: "blue"
  attr :element, :string, default: "div"
  attr :invisible, :boolean, default: false
  attr :position, :string, default: "top_right"
  attr :rest, :global

  slot :badge, required: true, validate_attrs: false do
    attr :class, :any, doc: "Extend existing component styles"
  end

  slot :inner_block, required: true

  @spec badge(Socket.assigns()) :: Rendered.t()
  def badge(assigns) do
    ~H"""
    <.dynamic_tag
      class={["badge-wrapper relative inline-block", assigns[:class]]}
      tag_name={@element}
      {@rest}
    >
      {render_slot(@inner_block)}
      <.dynamic_tag
        :for={badge <- Enum.take(@badge, 1)}
        class={[
          "badge inline-block absolute text-xs text-white rounded-full text-center transition-all ease-in-out duration-300",
          "py-0.5 px-1 min-h-2 min-w-2",
          styles(:border, assigns),
          styles(:color, assigns),
          styles(:invisible, assigns),
          styles(:position, assigns),
          styles(:variant, assigns),
          badge[:class]
        ]}
        tag_name={badge[:element] || "span"}
        {assigns_to_attributes(badge, [:class])}
      >
        {render_slot(badge)}
      </.dynamic_tag>
    </.dynamic_tag>
    """
  end

  ### Styles ##########################

  # Border
  defp styles(:border, %{border: true}), do: "border-2 border-zinc-100 dark:border-zinc-900"

  # Color
  defp styles(:color, %{color: "blue"}), do: "bg-blue-600"
  defp styles(:color, %{color: "green"}), do: "bg-green-600"
  defp styles(:color, %{color: "red"}), do: "bg-red-600"

  # Visibility
  defp styles(:invisible, %{invisible: true}), do: "invisible"

  # Position
  defp styles(:position, %{position: "bottom"}) do
    "bottom-0 translate-y-1/2 left-1/2 -translate-x-1/2"
  end

  defp styles(:position, %{position: "bottom_right"}) do
    "bottom-0 translate-y-1/2 right-0 translate-x-1/2"
  end

  defp styles(:position, %{position: "bottom_left"}) do
    "bottom-0 translate-y-1/2 left-0 -translate-x-1/2"
  end

  defp styles(:position, %{position: "left"}) do
    "top-1/2 -translate-y-1/2 left-0 -translate-x-1/2"
  end

  defp styles(:position, %{position: "right"}) do
    "top-1/2 -translate-y-1/2 right-0 translate-x-1/2"
  end

  defp styles(:position, %{position: "top"}) do
    "top-0 -translate-y-1/2 left-1/2 -translate-x-1/2"
  end

  defp styles(:position, %{position: "top_left"}) do
    "top-0 -translate-y-1/2 left-0 -translate-x-1/2"
  end

  defp styles(:position, %{position: "top_right"}) do
    "top-0 -translate-y-1/2 right-0 translate-x-1/2"
  end

  defp styles(_rule_group, _assigns), do: nil
end
