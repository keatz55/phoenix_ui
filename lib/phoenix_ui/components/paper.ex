defmodule PhoenixUI.Components.Paper do
  @moduledoc """
  Provides paper component.
  """
  import PhoenixUI.Components.Element

  use PhoenixUI, :component

  @default_blur false
  @default_element "div"
  @default_elevation 2
  @default_square false
  @default_variant "elevated"

  @doc """
  Renders paper component

  ## Examples

      ```
      <.paper>
        content
      </.paper>

  """
  @spec paper(Socket.assigns()) :: Rendered.t()
  def paper(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:blur, fn -> @default_blur end)
      |> assign_new(:element, fn -> @default_element end)
      |> assign_new(:elevation, fn -> @default_elevation end)
      |> assign_new(:square, fn -> @default_square end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_paper_attrs()

    ~H"""
    <.element {@paper_attrs}>
      <%= render_slot(@inner_block) %>
    </.element>
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
    generate_all_classes(&paper/1,
      blur: [true, false, "none", "sm", "md", "lg", "xl", "2xl", "3xl"],
      elevation: [0, 1, 2, 3, 4, 5],
      square: [true, false],
      variant: ["elevated", "outlined"]
    )
  end

  ### Container Attrs ##########################

  defp build_paper_attrs(assigns) do
    class = build_class(~w(
      paper transition-all ease-in-out duration-300
      #{classes(:blur, assigns)}
      #{classes(:elevation, assigns)}
      #{classes(:square, assigns)}
      #{classes(:variant, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:element, :elevation, :extend_class, :square, :variant])
      |> Keyword.put_new(:class, class)
      |> Keyword.put(:variant, assigns[:element])

    assign(assigns, :paper_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Blur
  defp classes(:blur, %{blur: false, variant: "elevated"}), do: "bg-white dark:bg-slate-800"

  defp classes(:blur, %{blur: true, variant: "elevated"}) do
    "bg-white/75 dark:bg-slate-800/75 backdrop-blur"
  end

  defp classes(:blur, %{blur: blur, variant: "elevated"}) do
    "bg-white/75 dark:bg-slate-800/75 backdrop-blur-#{blur}"
  end

  # Elevation
  defp classes(:elevation, %{variant: "outlined"}), do: nil
  defp classes(:elevation, %{elevation: 0}), do: "shadow-none"
  defp classes(:elevation, %{elevation: 1}), do: "shadow-sm"
  defp classes(:elevation, %{elevation: 2}), do: "shadow"
  defp classes(:elevation, %{elevation: 3}), do: "shadow-lg"
  defp classes(:elevation, %{elevation: 4}), do: "shadow-xl"
  defp classes(:elevation, %{elevation: 5}), do: "shadow-2xl"

  # Square
  defp classes(:square, %{square: false}), do: "rounded-lg"

  # Variant
  defp classes(:variant, %{variant: "elevated"}) do
    "border boder-slate-200 dark:border-slate-700"
  end

  defp classes(:variant, %{variant: "outlined"}), do: "border dark:border-slate-500"

  defp classes(_rule_group, _assigns), do: nil
end
