defmodule PhoenixUIWeb.Components.Button do
  @moduledoc """
  Provides button-related components.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  @doc """
  Buttons allow users to take actions, and make choices, with a single tap.

  ## Examples

  ```heex
  <.button>
    Click me
  </.button>
  ```
  """

  attr :class, :any, doc: "Extend existing styles applied to the component."
  attr :color, :string, default: "blue", doc: "The color of the component."
  attr :element, :string, default: "button", doc: "The HTML element to use, such as `div`."
  attr :full_width, :boolean, doc: "Determines if will take up full width of container."
  attr :rest, :global, doc: "Arbitrary HTML or phx attributes."
  attr :size, :string, default: "md", doc: "The button size.", values: ["xs", "sm", "md", "lg"]
  attr :square, :boolean, default: false, doc: "If true, rounded corners are disabled."
  attr :type, :string, default: "button"
  attr :variant, :string, default: "solid", values: ["plain", "outline", "solid"]

  slot :inner_block, required: true

  @spec button(Socket.assigns()) :: Rendered.t()
  def button(assigns) do
    ~H"""
    <.dynamic_tag
      class={
        [
          # Base
          "button button-#{@variant} relative isolate inline-flex items-center justify-center space-x-2 border font-semibold transition-all duration-100 ease-in",
          # Focus
          "focus:outline-none focus:outline focus:outline-2 focus:outline-offset-2 focus:outline-blue-500",
          # Disabled
          "disabled:opacity-50 disabled:cursor-not-allowed",
          # Icon
          "[&_.icon]:size-5 [&_.icon]:-mx-0.5 [&_.icon]:my-0.5 [&_.icon]:transition-all [&_.icon]:duration-100 [&_.icon]:ease-in",
          # Styles
          styles(:color, assigns),
          styles(:full_width, assigns),
          styles(:size, assigns),
          styles(:square, assigns),
          styles(:variant, assigns),
          assigns[:class]
        ]
      }
      tag_name={@element}
      type={@element == "button" && @type}
      {@rest}
    >
      {render_slot(@inner_block)}
    </.dynamic_tag>
    """
  end

  ### Styles ##########################

  # Color
  defp styles(:color, %{color: "blue", variant: "plain"}) do
    [
      # Base
      "text-blue-700 hover:bg-blue-950/5 disabled:hover:bg-transparent",
      # Dark mode
      "dark:text-blue-500 dark:hover:bg-blue-400/10",
      # Icon
      "[&_.icon]:text-blue-500 [&_.icon]:hover:text-blue-400 [&_.icon]:disabled:hover:text-blue-500 [&_.icon]:dark:hover:text-blue-400"
    ]
  end

  defp styles(:color, %{color: "pink", variant: "plain"}) do
    [
      # Base
      "text-pink-700 hover:bg-pink-950/5 disabled:hover:bg-transparent",
      # Dark mode
      "dark:text-pink-500 dark:hover:bg-pink-400/10",
      # Icon
      "[&_.icon]:text-pink-500 [&_.icon]:hover:text-pink-400 [&_.icon]:disabled:hover:text-pink-500 [&_.icon]:dark:hover:text-pink-400"
    ]
  end

  defp styles(:color, %{color: "blue", variant: "outline"}) do
    [
      # Base
      "border-blue-700 text-blue-700 hover:bg-blue-700/5 disabled:hover:bg-transparent",
      # Dark mode
      "dark:border-blue-500 dark:text-blue-500 dark:hover:bg-blue-400/5",
      # Icon
      "[&_.icon]:text-blue-500 [&_.icon]:hover:text-blue-400 [&_.icon]:disabled:hover:text-blue-500 [&_.icon]:dark:hover:text-blue-400"
    ]
  end

  defp styles(:color, %{color: "red", variant: "outline"}) do
    [
      # Base
      "border-red-700 text-red-700 hover:bg-red-700/5 disabled:hover:bg-transparent",
      # Dark mode
      "dark:border-red-500 dark:text-red-500 dark:hover:bg-red-400/5",
      # Icon
      "[&_.icon]:text-red-500 [&_.icon]:hover:text-red-400 [&_.icon]:disabled:hover:text-red-500 [&_.icon]:dark:hover:text-red-400"
    ]
  end

  defp styles(:color, %{color: "blue", variant: "solid"}) do
    [
      # Base
      "before:bg-blue-600 bg-blue-700/90",
      # Icon
      "[&_.icon]:text-blue-400 [&_.icon]:hover:text-blue-300 [&_.icon]:disabled:hover:text-blue-400"
    ]
  end

  defp styles(:color, %{color: "green", variant: "solid"}) do
    [
      # Base
      "before:bg-green-600 bg-green-700/90",
      # Icon
      "[&_.icon]:text-green-400 [&_.icon]:hover:text-green-300 [&_.icon]:disabled:hover:text-green-400"
    ]
  end

  # Full width
  defp styles(:full_width, %{full_width: true}), do: "w-full"

  # Size
  defp styles(:size, %{size: "xs"}), do: "px-1.5 py-1 text-xs"
  defp styles(:size, %{size: "sm"}), do: "px-3 py-1.5 text-sm"
  defp styles(:size, %{size: "md"}), do: "px-3.5 py-2 text-base"
  defp styles(:size, %{size: "lg"}), do: "px-5 py-2.5 text-xl font-bold"

  # Square
  defp styles(:square, %{square: false}) do
    "rounded-lg before:rounded-[calc(theme(borderRadius.lg)-1px)] after:rounded-[calc(theme(borderRadius.lg)-1px)]"
  end

  # Variant
  defp styles(:variant, %{variant: "plain"}), do: "border-transparent"

  defp styles(:variant, %{variant: "solid"}) do
    [
      # Optical border, implemented as the button background to avoid corner artifacts
      "border-transparent text-white after:hover:bg-white/10 ",
      # Button background, implemented as foreground layer to stack on top of pseudo-border layer
      "before:absolute before:inset-0 before:-z-10",
      # Drop shadow, applied to the inset `before` layer so it blends with the border
      "before:shadow",
      # Shim/overlay, inset to match button foreground and used for hover state + highlight shadow
      "after:absolute after:inset-0 after:-z-10",
      # Inner highlight shadow
      "after:shadow-[shadow:inset_0_1px_theme(colors.white/15%)]",
      # Disabled
      "before:disabled:shadow-none after:disabled:hidden"
    ]
  end

  defp styles(_rule_group, _assigns), do: nil
end
