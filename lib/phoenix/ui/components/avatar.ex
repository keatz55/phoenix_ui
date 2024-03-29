defmodule Phoenix.UI.Components.Avatar do
  @moduledoc """
  Provides avatar component.
  """
  import Phoenix.UI.Components.Heroicon

  use Phoenix.UI, :component

  attr(:border, :boolean, default: false)
  attr(:color, :string, default: "slate", values: Theme.colors())
  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:rest, :global)
  attr(:size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"])
  attr(:variant, :string, default: "circular", values: ["circular", "rounded"])

  slot(:inner_block)

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
    |> assign_class(~w(
      avatar relative overflow-hidden font-semibold
      inline-flex items-center justify-center
      #{classes(:border, assigns)}
      #{classes(:color, assigns)}
      #{classes(:size, assigns)}
      #{classes(:variant, assigns)}
    ))
    |> generate_markup()
  end

  ### Markup ##########################

  defp generate_markup(%{rest: %{src: src}} = assigns) when not is_nil(src) do
    ~H"""
    <img class={@class} {@rest} />
    """
  end

  defp generate_markup(%{inner_block: [], rest: %{alt: alt}} = assigns) when not is_nil(alt) do
    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= build_initials(@rest[:alt]) %>
    </.dynamic_tag>
    """
  end

  defp generate_markup(%{inner_block: []} = assigns) do
    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <.heroicon
        extend_class="absolute scale-125 top-[15%]"
        name="user"
        size={icon_size_mapping(@size)}
        variant="mini"
      />
    </.dynamic_tag>
    """
  end

  defp generate_markup(assigns) do
    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
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
