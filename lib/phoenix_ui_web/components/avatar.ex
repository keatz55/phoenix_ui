defmodule PhoenixUIWeb.Components.Avatar do
  @moduledoc """
  Provides avatar-related components.
  """
  use Phoenix.Component

  import PhoenixUIWeb.CoreComponents, only: [icon: 1]

  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  @doc """
  Avatar components are used to represent a user, and displays the profile picture, initials or fallback icon.

  ## Examples

  ```heex
  <.avatar src={@src} />
  ```
  """

  attr :alt, :string
  attr :border, :boolean, default: false
  attr :class, :any, doc: "Extend existing component styles"
  attr :color, :string, default: "zinc"
  attr :element, :string, default: "div"
  attr :rest, :global
  attr :size, :string, default: "md"
  attr :src, :string
  attr :variant, :string, default: "circular", values: ["circular", "rounded", "square"]

  slot :inner_block

  @spec avatar(Socket.assigns()) :: Rendered.t()
  def avatar(assigns) do
    assigns
    |> assign(:class, [
      # Default styles
      "avatar relative overflow-hidden font-semibold inline-flex items-center justify-center",
      # Icon default styles
      "[&_.icon]:absolute [&_.icon]:scale-125 [&_.icon]:top-[15%]",
      styles(:border, assigns),
      styles(:color, assigns),
      styles(:size, assigns),
      styles(:variant, assigns),
      assigns[:class]
    ])
    |> generate_markup()
  end

  ### Markup ##########################

  defp generate_markup(%{src: src} = assigns) when not is_nil(src) do
    ~H"""
    <img alt={assigns[:alt]} class={@class} src={@src} {@rest} />
    """
  end

  defp generate_markup(%{alt: alt, inner_block: []} = assigns) when not is_nil(alt) do
    ~H"""
    <.dynamic_tag class={@class} tag_name={@element} {@rest}>
      {build_initials(@alt)}
    </.dynamic_tag>
    """
  end

  defp generate_markup(%{inner_block: []} = assigns) do
    ~H"""
    <.dynamic_tag class={@class} tag_name={@element} {@rest}>
      <.icon class="icon" name="hero-user-mini" />
    </.dynamic_tag>
    """
  end

  defp generate_markup(assigns) do
    ~H"""
    <.dynamic_tag class={@class} tag_name={@element} {@rest}>
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  ### Styles ##########################

  # Border
  defp styles(:border, %{border: true}), do: "ring-2 ring-white"

  # Color
  defp styles(:color, %{color: "blue"}) do
    "bg-blue-300 text-blue-600 dark:bg-blue-600 dark:text-blue-200"
  end

  defp styles(:color, %{color: "green"}) do
    "bg-green-300 text-green-600 dark:bg-green-600 dark:text-green-200"
  end

  defp styles(:color, %{color: "orange"}) do
    "bg-orange-300 text-orange-600 dark:bg-orange-600 dark:text-orange-200"
  end

  defp styles(:color, %{color: "red"}) do
    "bg-red-300 text-red-600 dark:bg-red-600 dark:text-red-200"
  end

  defp styles(:color, %{color: "yellow"}) do
    "bg-yellow-300 text-yellow-600 dark:bg-yellow-600 dark:text-yellow-200"
  end

  defp styles(:color, %{color: _color}) do
    "bg-zinc-300 text-zinc-600 dark:bg-zinc-600 dark:text-zinc-200"
  end

  # Size
  defp styles(:size, %{size: "xs"}), do: "[&_.icon]:w-6 [&_.icon]:h-6 w-6 h-6 text-xs"
  defp styles(:size, %{size: "sm"}), do: "[&_.icon]:w-8 [&_.icon]:h-8 w-8 h-8 text-xs"
  defp styles(:size, %{size: "md"}), do: "[&_.icon]:w-10 [&_.icon]:h-10 w-10 h-10 text-base"
  defp styles(:size, %{size: "lg"}), do: "[&_.icon]:w-12 [&_.icon]:h-12 w-12 h-12 text-lg"
  defp styles(:size, %{size: "xl"}), do: "[&_.icon]:w-14 [&_.icon]:h-14 w-14 h-14 text-xl"
  defp styles(:size, %{size: override}), do: override

  # Variant
  defp styles(:variant, %{variant: "circular"}), do: "rounded-full"
  defp styles(:variant, %{variant: "rounded"}), do: "rounded"

  defp styles(_rule_group, _assigns), do: nil

  ### Helpers functions ##########################

  defp build_initials(name) do
    name
    |> String.split(" ")
    |> case do
      [part1 | [part2 | _]] -> String.slice(part1, 0, 1) <> String.slice(part2, 0, 1)
      [part] -> String.slice(part, 0, 1)
    end
    |> String.upcase()
  end
end
