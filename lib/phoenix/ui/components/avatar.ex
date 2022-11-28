defmodule Phoenix.UI.Components.Avatar do
  @moduledoc """
  Provides avatar-related components.
  """
  import Phoenix.UI.Components.Heroicon

  use Phoenix.UI, :component

  ### Avatar ##########################

  attr(:border, :boolean, default: false)
  attr(:color, :string, default: "slate", values: Theme.colors())
  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:rest, :global)
  attr(:size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"])
  attr(:variant, :string, default: "circular", values: ["circular", "rounded"])

  slot(:inner_block)

  @doc """
  An avatar is a visual representation of a user or entity.

  ## Examples

      <.avatar src={@src} />

  """
  @spec avatar(Socket.assigns()) :: Rendered.t()
  def avatar(assigns) do
    assigns
    |> assign_class(~w(
      avatar relative overflow-hidden font-semibold
      inline-flex items-center justify-center
      #{avatar_classes(:border, assigns)}
      #{avatar_classes(:color, assigns)}
      #{avatar_classes(:size, assigns)}
      #{avatar_classes(:variant, assigns)}
    ))
    |> avatar_markup()
  end

  defp avatar_markup(%{rest: %{src: src}} = assigns) when not is_nil(src) do
    ~H"""
    <img class={@class} {@rest} />
    """
  end

  defp avatar_markup(%{inner_block: [], rest: %{alt: alt}} = assigns) when not is_nil(alt) do
    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= avatar_initials(@rest[:alt]) %>
    </.dynamic_tag>
    """
  end

  defp avatar_markup(%{inner_block: []} = assigns) do
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

  defp avatar_markup(assigns) do
    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  # Border
  defp avatar_classes(:border, %{border: true}), do: "ring-2 ring-white"

  # Color
  defp avatar_classes(:color, %{color: color}) do
    "bg-#{color}-300 text-slate-600 dark:bg-#{color}-600 dark:text-slate-200"
  end

  # Size
  defp avatar_classes(:size, %{size: "xs"}), do: "w-6 h-6 text-xs"
  defp avatar_classes(:size, %{size: "sm"}), do: "w-8 h-8 text-sm"
  defp avatar_classes(:size, %{size: "md"}), do: "w-10 h-10 text-base"
  defp avatar_classes(:size, %{size: "lg"}), do: "w-12 h-12 text-lg"
  defp avatar_classes(:size, %{size: "xl"}), do: "w-14 h-14 text-xl"
  defp avatar_classes(:size, %{size: val}), do: "w-[#{val}rem] h-[#{val}rem]"

  # Variant
  defp avatar_classes(:variant, %{variant: "circular"}), do: "rounded-full"
  defp avatar_classes(:variant, %{variant: "rounded"}), do: "rounded"

  defp avatar_classes(_rule_group, _assigns), do: nil

  defp avatar_initials(name) do
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

  ### Avatar Group ##########################

  attr(:border, :boolean, default: true)
  attr(:color, :string, default: "slate", values: Theme.colors())
  attr(:element, :string, default: "div")
  attr(:max, :integer, default: 5)
  attr(:rest, :global)
  attr(:size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"])
  attr(:spacing, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"])
  attr(:variant, :string, default: "circular", values: ["circular", "rounded"])

  slot(:avatar)

  @doc """
  An avatar group displays a number of avatars grouped together in a stack or grid.

  ## Examples

      <.avatar_group>
        <:avatar src={@src1}/>
        <:avatar src={@src2}/>
        <:avatar src={@src3}/>
        ...
      </.avatar_group>

  """
  @spec avatar_group(Socket.assigns()) :: Rendered.t()
  def avatar_group(assigns) do
    spacing = spacing_mapping(assigns[:spacing])

    assigns =
      assigns
      |> assign_class(~w(avatar-group inline-flex flex-row-reverse items-center pl-#{spacing}))
      |> calc_total()
      |> calc_extra()
      |> normalize_avatar_group_avatars()

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= if (@total - @max) > 0 do %>
        <.avatar
          border={@border}
          color={@color}
          extend_class={"avatar-group-avatar -ml-#{spacing_mapping(@spacing)}"}
          size={@size}
          variant={@variant}
        >
          +<%= @total - @max %>
        </.avatar>
      <% end %>
      <%= for avatar <- @avatar do %>
        <.avatar {avatar} />
      <% end %>
    </.dynamic_tag>
    """
  end

  defp calc_total(%{avatar: avatars} = assigns) do
    assign_new(assigns, :total, fn -> length(avatars) end)
  end

  defp calc_extra(%{max: max, total: total} = assigns) do
    assign_new(assigns, :extra, fn -> total - max end)
  end

  defp normalize_avatar_group_avatars(
         %{avatar: [_ | _] = avatars, max: max, total: total} = assigns
       ) do
    take_count = if max >= total, do: total, else: max
    spacing = spacing_mapping(assigns[:spacing])

    avatar =
      avatars
      |> Enum.take(take_count)
      |> Enum.map(fn avatar ->
        extend_class = build_class(~w(
          avatar-group-avatar -ml-#{spacing}
          #{Map.get(avatar, :extend_class)}
        ))

        avatar
        |> Map.put_new(:border, assigns[:border])
        |> Map.put_new(:color, assigns[:color])
        |> Map.put_new(:size, assigns[:size])
        |> Map.put_new(:variant, assigns[:variant])
        |> Map.put(:extend_class, extend_class)
        |> apply_avatar_inner_block()
      end)
      |> Enum.reverse()

    assign(assigns, :avatar, avatar)
  end

  defp spacing_mapping("xs"), do: "2.5"
  defp spacing_mapping("sm"), do: "2"
  defp spacing_mapping("md"), do: "1.5"
  defp spacing_mapping("lg"), do: "1"
  defp spacing_mapping("xl"), do: "0.5"

  defp apply_avatar_inner_block(%{inner_block: nil} = avatar) do
    Map.put(avatar, :inner_block, [])
  end

  defp apply_avatar_inner_block(avatar), do: avatar
end
