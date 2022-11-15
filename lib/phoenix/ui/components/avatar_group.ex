defmodule Phoenix.UI.Components.AvatarGroup do
  @moduledoc """
  Provides avatar_group component.
  """
  import Phoenix.UI.Components.Avatar, only: [avatar: 1]

  use Phoenix.UI, :component

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
  Renders avatar_group component.

  ## Examples

      ```
      <.avatar_group>
        <:avatar src={@src1}/>
        <:avatar src={@src2}/>
        <:avatar src={@src3}/>
        ...
      </.avatar_group>
      ```

  """
  @spec avatar_group(Socket.assigns()) :: Rendered.t()
  def avatar_group(prev_assigns) do
    spacing = spacing_mapping(prev_assigns[:spacing])

    assigns =
      prev_assigns
      |> assign_class(~w(avatar-group inline-flex flex-row-reverse items-center pl-#{spacing}))
      |> calc_total()
      |> calc_extra()
      |> normalize_avatars()

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

  ### Normalize Avatars ##########################

  defp normalize_avatars(%{avatar: [_ | _] = avatars, max: max, total: total} = assigns) do
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
