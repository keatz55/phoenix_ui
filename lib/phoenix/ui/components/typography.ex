defmodule Phoenix.UI.Components.Typography do
  @moduledoc """
  Provides typography component.
  """
  use Phoenix.UI, :component

  attr(:align, :string, default: "left", values: ["center", "justify", "left", "right"])

  attr(:bold, :string,
    values: [
      "thin",
      "extralight",
      "light",
      "normal",
      "medium",
      "semibold",
      "bold",
      "extrabold",
      "black"
    ]
  )

  attr(:color, :string, default: "slate", values: Theme.colors())
  attr(:element, :string)
  attr(:extend_class, :string)
  attr(:margin, :boolean, default: true)
  attr(:rest, :global)

  attr(:size, :string,
    values: ["xs", "sm", "md", "lg", "xl", "2xl", "3xl", "4xl", "5xl", "6xl", "7xl", "8xl", "9xl"]
  )

  attr(:variant, :string, default: "p", values: ["h1", "h2", "h3", "h4", "p"])

  slot(:inner_block, required: true)

  @doc """
  Renders typography component.

  ## Examples

      ```
      <.typography variant="p">
        text
      </.typography>
      ```

  """
  @spec typography(Socket.assigns()) :: Rendered.t()
  def typography(assigns) do
    assigns = assign_class(assigns, ~w(
        typography
        #{classes(:align, assigns)}
        #{classes(:color, assigns)}
        #{classes(:margin, assigns)}
        #{classes(:size, assigns)}
        #{classes(:variant, assigns)}
        #{classes(:weight, assigns)}
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@variant} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### CSS Classes ##########################

  # Align
  defp classes(:align, %{align: "center"}), do: "text-center"
  defp classes(:align, %{align: "justify"}), do: "text-justify"
  defp classes(:align, %{align: "left"}), do: "text-left"
  defp classes(:align, %{align: "right"}), do: "text-right"

  # Color
  defp classes(:color, %{color: "inherit"}), do: nil
  defp classes(:color, %{color: "slate", variant: "p"}), do: "text-slate-600 dark:text-slate-300"
  defp classes(:color, %{color: "slate"}), do: "text-slate-700 dark:text-slate-200"
  defp classes(:color, %{color: color}), do: "text-#{color}-500"

  # Margin
  defp classes(:margin, %{margin: false}), do: nil
  defp classes(:margin, %{variant: "h1"}), do: "mt-0 mb-3.5"
  defp classes(:margin, %{variant: "h2"}), do: "mt-8 mb-4"
  defp classes(:margin, %{variant: "h3"}), do: "mt-6 mb-4"
  defp classes(:margin, %{variant: "h4"}), do: "mt-6 mb-2"
  defp classes(:margin, %{variant: "p"}), do: "mt-5 mb-5"

  # Size
  defp classes(:size, %{size: "xs"}), do: "text-xs"
  defp classes(:size, %{size: "sm"}), do: "text-sm"
  defp classes(:size, %{size: "md"}), do: "text-base"
  defp classes(:size, %{size: "lg"}), do: "text-lg"
  defp classes(:size, %{size: "xl"}), do: "text-xl"
  defp classes(:size, %{size: "2xl"}), do: "text-2xl"
  defp classes(:size, %{size: "3xl"}), do: "text-3xl"
  defp classes(:size, %{size: "4xl"}), do: "text-4xl"
  defp classes(:size, %{size: "5xl"}), do: "text-5xl"
  defp classes(:size, %{size: "6xl"}), do: "text-6xl"
  defp classes(:size, %{size: "7xl"}), do: "text-7xl"
  defp classes(:size, %{size: "8xl"}), do: "text-8xl"
  defp classes(:size, %{size: "9xl"}), do: "text-9xl"

  defp classes(:size, %{variant: "h1"}), do: "text-4xl"
  defp classes(:size, %{variant: "h2"}), do: "text-2xl"
  defp classes(:size, %{variant: "h3"}), do: "text-xl"
  defp classes(:size, %{variant: "h4"}), do: "text-base sm:text-sm lg:text-lg"
  defp classes(:size, %{variant: "p"}), do: "text-base sm:text-sm lg:text-lg"

  # Variant
  defp classes(:variant, %{variant: "h1"}), do: "leading-tight"
  defp classes(:variant, %{variant: "h2"}), do: "leading-tight"
  defp classes(:variant, %{variant: "h3"}), do: "leading-snug"
  defp classes(:variant, %{variant: "h4"}), do: "leading-normal"
  defp classes(:variant, %{variant: "p"}), do: "leading-7"

  # Weight
  defp classes(:weight, %{weight: "thin"}), do: "font-thin"
  defp classes(:weight, %{weight: "extralight"}), do: "font-extralight"
  defp classes(:weight, %{weight: "light"}), do: "font-light"
  defp classes(:weight, %{weight: "normal"}), do: "font-normal"
  defp classes(:weight, %{weight: "medium"}), do: "font-medium"
  defp classes(:weight, %{weight: "semibold"}), do: "font-semibold"
  defp classes(:weight, %{weight: "bold"}), do: "font-bold"
  defp classes(:weight, %{weight: "extrabold"}), do: "font-extrabold"
  defp classes(:weight, %{weight: "black"}), do: "font-black"

  defp classes(:weight, %{variant: "h1"}), do: "font-extrabold"
  defp classes(:weight, %{variant: "h2"}), do: "font-bold"
  defp classes(:weight, %{variant: "h3"}), do: "font-semibold"
  defp classes(:weight, %{variant: "h4"}), do: "font-semibold"
  defp classes(:weight, %{variant: "p"}), do: "font-normal"

  defp classes(_rule_group, _assigns), do: nil
end
