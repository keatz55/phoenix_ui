defmodule PhoenixUIWeb.Components.Progress do
  @moduledoc """
  Provides progress-related components.
  """
  use PhoenixUIWeb, :component

  @doc """
  A progress component displays the status of a given process.

  ## Examples

  ```heex
  <.progress variant="radial" />
  ```
  """

  attr :class, :any, doc: "Extend existing component styles"
  attr :color, :string, default: "blue", doc: "The color of the component."
  attr :rest, :global, doc: "Arbitrary HTML or phx attributes"
  attr :size, :any, default: "md", doc: "The size of the component"
  attr :square, :boolean, default: false, doc: "If true, rounded corners are disabled"
  attr :text, :string, default: nil, doc: "Draws a graphics element consisting of text"
  attr :value, :integer, default: 30, doc: "The value of the progress indicator"
  attr :variant, :string, default: "radial", values: ["linear", "radial"]

  @spec progress(Socket.assigns()) :: Rendered.t()
  def progress(%{variant: "radial"} = assigns) do
    ~H"""
    <svg
      aria-hidden="true"
      class={[
        "progress block",
        styles(:color, assigns),
        styles(:size, assigns),
        assigns[:class]
      ]}
      fill="none"
      viewBox="0 0 36 36"
      xmlns="http://www.w3.org/2000/svg"
      {@rest}
    >
      <path
        class="stroke-zinc-200 dark:stroke-zinc-700"
        d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
        fill="none"
        stroke-width="3.8"
      />
      <path
        class="stroke-current"
        d="M18 2.0845 a 15.9155 15.9155 0 0 1 0 31.831 a 15.9155 15.9155 0 0 1 0 -31.831"
        fill="none"
        stroke-dasharray={"#{@value}, 100"}
        stroke-width="3.8"
        stroke-linecap={@square == false && "round"}
      />
      <text
        :if={@text}
        class="fill-zinc-500 dark:fill-zinc-200 text-[0.5em]"
        text-anchor="middle"
        x="18"
        y="20.35"
      >
        {@text}
      </text>
    </svg>
    """
  end

  def progress(assigns) do
    ~H"""
    <div
      class={[
        "progress w-full h-3 bg-zinc-200 dark:bg-zinc-700 overflow-hidden",
        styles(:size, assigns),
        styles(:square, assigns),
        assigns[:class]
      ]}
      {@rest}
    >
      <div
        class={[
          "h-3 flex items-center justify-center p-0.5 leading-none",
          styles(:color, assigns),
          styles(:size, assigns),
          styles(:square, assigns)
        ]}
        style={"width: #{@value}%"}
      >
        <span :if={@text && @value > 0}>{@text}</span>
      </div>
    </div>
    """
  end

  ### Styles ##########################

  # Color
  defp styles(:color, %{color: "blue", variant: "linear"}), do: "bg-blue-500 text-blue-100"
  defp styles(:color, %{color: "green", variant: "linear"}), do: "bg-green-500 text-green-100"
  defp styles(:color, %{color: "red", variant: "linear"}), do: "bg-red-500 text-red-100"

  defp styles(:color, %{color: "blue", variant: "radial"}), do: "text-blue-500"
  defp styles(:color, %{color: "green", variant: "radial"}), do: "text-green-500"
  defp styles(:color, %{color: "red", variant: "radial"}), do: "text-red-500"

  # Size
  defp styles(:size, %{size: "sm", variant: "linear"}), do: "h-3.5 text-xs"
  defp styles(:size, %{size: "md", variant: "linear"}), do: "h-5 text-sm font-semibold"
  defp styles(:size, %{size: "lg", variant: "linear"}), do: "h-7 text-base font-medium"

  defp styles(:size, %{size: "sm", variant: "radial"}), do: "h-8 w-8 text-sm"
  defp styles(:size, %{size: "md", variant: "radial"}), do: "h-12 w-12 text-sm"
  defp styles(:size, %{size: "lg", variant: "radial"}), do: "h-16 w-16 text-sm"

  # Square
  defp styles(:square, %{square: false}), do: "rounded-full"

  defp styles(_rule_group, _assigns), do: nil
end
