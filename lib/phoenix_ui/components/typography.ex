defmodule PhoenixUI.Components.Typography do
  @moduledoc """
  Provides typography component.
  """
  use PhoenixUI, :component

  @default_variant "p"
  @default_color "slate"

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
  def typography(raw) do
    assigns =
      raw
      |> assign_new(:color, fn -> @default_color end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_typography_attrs()

    ~H"""
    <.dynamic_tag {@typography_attrs}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  @doc """
  Returns all possible component classes for Tailwind CSS JIT compilation.

  ## Examples

      iex> classes()
      ["class1", "class2", ...]

  """
  @spec classes :: [String.t()]
  def classes do
    generate_all_classes(&typography/1,
      align: ["center", "justify", "left", "right"],
      color: Theme.colors(),
      variant: ["h1", "h2", "h3", "h4", "p"]
    )
  end

  ### Typography Attrs ##########################

  defp build_typography_attrs(assigns) do
    dynamic_tag_name = assigns[:element] || assigns[:variant]

    class = build_class(~w(
      typography
      #{classes(:align, assigns)}
      #{classes(:color, assigns)}
      #{classes(:font_size, assigns)}
      #{classes(:margin, assigns)}
      #{classes(:variant, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:align, :color, :element, :extend_class, :variant])
      |> Keyword.put_new(:class, class)
      |> Keyword.put(:name, dynamic_tag_name)

    assign(assigns, :typography_attrs, attrs)
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

  # Font Size
  defp classes(:font_size, %{variant: "h1"}), do: "text-4xl"
  defp classes(:font_size, %{variant: "h2"}), do: "text-2xl"
  defp classes(:font_size, %{variant: "h3"}), do: "text-xl"
  defp classes(:font_size, %{variant: "h4"}), do: "text-base sm:text-sm lg:text-lg"
  defp classes(:font_size, %{variant: "p"}), do: "text-base sm:text-sm lg:text-lg"

  # Margin
  defp classes(:margin, %{margin: false}), do: nil
  defp classes(:margin, %{variant: "h1"}), do: "mt-0 mb-3.5"
  defp classes(:margin, %{variant: "h2"}), do: "mt-8 mb-4"
  defp classes(:margin, %{variant: "h3"}), do: "mt-6 mb-4"
  defp classes(:margin, %{variant: "h4"}), do: "mt-6 mb-2"
  defp classes(:margin, %{variant: "p"}), do: "mt-5 mb-5"

  # Variant
  defp classes(:variant, %{variant: "h1"}), do: "leading-tight font-extrabold"
  defp classes(:variant, %{variant: "h2"}), do: "leading-tight font-bold"
  defp classes(:variant, %{variant: "h3"}), do: "leading-snug font-semibold"
  defp classes(:variant, %{variant: "h4"}), do: "leading-normal font-semibold"
  defp classes(:variant, %{variant: "p"}), do: "leading-7 font-normal"

  defp classes(_rule_group, _assigns), do: nil
end
