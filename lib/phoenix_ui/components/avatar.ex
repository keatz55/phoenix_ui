defmodule PhoenixUI.Components.Avatar do
  @moduledoc """
  Provides avatar component.
  """
  import PhoenixUI.Components.{Element, Heroicon}

  use PhoenixUI, :component

  @default_border false
  @default_color "slate"
  @default_element "div"
  @default_size "md"
  @default_variant "circular"

  @doc """
  Renders avatar component.

  ## Examples

      ```
      <.avatar src={@src} />
      ```

  """
  @spec avatar(Socket.assigns()) :: Rendered.t()
  def avatar(assigns) do
    assigns
    |> assign_new(:border, fn -> @default_border end)
    |> assign_new(:color, fn -> @default_color end)
    |> assign_new(:element, fn -> @default_element end)
    |> assign_new(:size, fn -> @default_size end)
    |> assign_new(:variant, fn -> @default_variant end)
    |> build_avatar_attrs()
    |> generate_markup()
  end

  @doc """
  Returns all possible component classes for Tailwind CSS JIT compilation.

  ## Examples

      iex> classes()
      ["class1", "class2", ...]

  """
  @spec classes :: [String.t()]
  def classes do
    generate_all_classes(&avatar/1,
      inner_block: [nil, []],
      color: Theme.colors(),
      border: [true, false],
      size: ["xs", "sm", "md", "lg", "xl"] ++ range(0.25, 20, 0.25),
      variant: ["circular", "rounded", "square"]
    )
  end

  ### Markup ##########################

  defp generate_markup(%{src: src} = assigns) when not is_nil(src) do
    ~H"""
    <.element {@avatar_attrs}>
      <img alt={assigns[:alt]} class="avatar-image object-cover h-full w-full" src={@src} />
    </.element>
    """
  end

  defp generate_markup(%{inner_block: inner_block} = assigns) when not is_nil(inner_block) do
    ~H"""
    <.element {@avatar_attrs}>
      <%= render_slot(@inner_block) %>
    </.element>
    """
  end

  defp generate_markup(%{name: name} = assigns) when not is_nil(name) do
    ~H"""
    <.element {@avatar_attrs}>
      <%= build_initials(@name) %>
    </.element>
    """
  end

  defp generate_markup(assigns) do
    ~H"""
    <.element {@avatar_attrs}>
      <.heroicon
        extend_class="absolute scale-125 top-[15%]"
        name="user"
        size={icon_size_mapping(@size)}
        variant="solid"
      />
    </.element>
    """
  end

  ### Avatar Attrs ##########################

  defp build_avatar_attrs(assigns) do
    class = build_class(~w(
      avatar relative overflow-hidden font-semibold
      inline-flex items-center justify-center
      #{classes(:border, assigns)}
      #{classes(:color, assigns)}
      #{classes(:size, assigns)}
      #{classes(:variant, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([
        :alt,
        :border,
        :color,
        :element,
        :extend_class,
        :name,
        :size,
        :src,
        :variant
      ])
      |> Keyword.put(:variant, assigns[:element])
      |> Keyword.put_new(:class, class)

    assign(assigns, :avatar_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Border
  defp classes(:border, %{border: true}), do: "ring-2 ring-white"

  # Color
  defp classes(:color, %{color: color}) do
    "bg-#{color}-300 text-slate-600 dark:bg-#{color}-600 dark:text-slate-200"
  end

  # Size
  defp classes(:size, %{size: "xs"}), do: "w-6 h-6 text-xs"
  defp classes(:size, %{size: "sm"}), do: "w-8 h-8 text-sm"
  defp classes(:size, %{size: "md"}), do: "w-10 h-10 text-base"
  defp classes(:size, %{size: "lg"}), do: "w-12 h-12 text-lg"
  defp classes(:size, %{size: "xl"}), do: "w-14 h-14 text-xl"
  defp classes(:size, %{size: val}), do: "w-[#{val}rem] h-[#{val}rem]"

  # Variant
  defp classes(:variant, %{variant: "circular"}), do: "rounded-full"
  defp classes(:variant, %{variant: "rounded"}), do: "rounded"

  defp classes(_rule_group, _assigns), do: nil

  ### Misc. Helpers ##########################

  defp build_initials(name) do
    name
    |> String.split(" ")
    |> case do
      [part1 | [part2 | _]] -> String.slice(part1, 0, 1) <> String.slice(part2, 0, 1)
      [part] -> String.slice(part, 0, 1)
    end
    |> String.upcase()
  end

  defp icon_size_mapping("xs"), do: 1.5
  defp icon_size_mapping("sm"), do: 2
  defp icon_size_mapping("md"), do: 2.5
  defp icon_size_mapping("lg"), do: 3
  defp icon_size_mapping("xl"), do: 3.5
  defp icon_size_mapping(size), do: size
end
