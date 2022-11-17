defmodule Phoenix.UI.Components.Chip do
  @moduledoc """
  Provides chip component.
  """
  import Phoenix.UI.Components.{Avatar, Heroicon}

  use Phoenix.UI, :component

  @default_avatar_size 2
  @default_delete_icon_name "x-circle"
  @default_icon_color "inherit"

  attr(:avatar, :list)
  attr(:color, :string, default: "slate", values: Theme.colors())
  attr(:delete_icon, :list)
  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:icon, :list)
  attr(:label, :string)
  attr(:rest, :global)
  attr(:size, :string, default: "md", values: ["sm", "md"])
  attr(:variant, :string, default: "filled", values: ["filled", "outlined"])

  @doc """
  Renders chip component.

  ## Examples

      ```
      <.chip label="keto"/>
      ```

  """
  @spec chip(Socket.assigns()) :: Rendered.t()
  def chip(assigns) do
    assigns =
      assigns
      |> assign_class(~w(
        inline-flex items-center rounded-full text-sm
        font-semibold transition-all ease-in-out duration-200
        #{classes(:clickable, assigns)}
        #{classes(:size, assigns)}
        #{classes(:variant, assigns)}
      ))
      |> build_avatar_attrs()
      |> build_icon_attrs()
      |> build_delete_icon_attrs()

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= if assigns[:avatar] do %>
        <.avatar {@avatar_attrs} />
      <% end %>
      <%= if !assigns[:avatar] && assigns[:icon] do %>
        <.heroicon {@icon_attrs} />
      <% end %>
      <%= @label %>
      <%= if assigns[:delete_icon] do %>
        <div class="ml-1 cursor-pointer text-slate-600 hover:text-slate-500">
          <.heroicon {@delete_icon_attrs} />
        </div>
      <% end %>
    </.dynamic_tag>
    """
  end

  ### Avatar Attrs ##########################

  defp build_avatar_attrs(%{avatar: avatar} = assigns) do
    extend_class = build_class(~w(
      mr-1
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      avatar
      |> assigns_to_attributes()
      |> Keyword.put(:extend_class, extend_class)
      |> Keyword.put_new(:size, @default_avatar_size)

    assign(assigns, :avatar_attrs, attrs)
  end

  defp build_avatar_attrs(assigns), do: assigns

  ### Icon Attrs ##########################

  defp build_icon_attrs(%{icon: icon} = assigns) do
    extend_class = build_class(~w(
      mr-1
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      icon
      |> assigns_to_attributes()
      |> Keyword.put_new(:color, @default_icon_color)
      |> Keyword.put(:extend_class, extend_class)

    assign(assigns, :icon_attrs, attrs)
  end

  defp build_icon_attrs(assigns), do: assigns

  ### Delete Icon Attrs ##########################

  defp build_delete_icon_attrs(%{delete_icon: icon} = assigns) do
    attrs =
      icon
      |> assigns_to_attributes()
      |> Keyword.put_new(:color, @default_icon_color)
      |> Keyword.put_new(:name, @default_delete_icon_name)

    assign(assigns, :delete_icon_attrs, attrs)
  end

  defp build_delete_icon_attrs(assigns), do: assigns

  ### CSS Classes ##########################

  # Clickable
  defp classes(:clickable, %{color: color, variant: "filled"} = assigns) do
    classes = "hover:bg-#{color}-200 dark:hover:bg-#{color}-200 cursor-pointer"

    case assigns do
      %{element: el} when el in ["a", "link", "live_patch", "live_redirect"] -> classes
      %{on_click: _} -> classes
      _assigns -> nil
    end
  end

  defp classes(:clickable, %{color: color, variant: "outlined"} = assigns) do
    classes = "hover:bg-#{color}-200/50 dark:hover:bg-#{color}-200/25 cursor-pointer"

    case assigns do
      %{element: el} when el in ["a", "link", "live_patch", "live_redirect"] -> classes
      %{on_click: _} -> classes
      _assigns -> nil
    end
  end

  # Size
  defp classes(:size, %{size: "sm", avatar: _}), do: "pl-0 pr-1.5"
  defp classes(:size, %{size: "sm", icon: _}), do: "py-0.5 pl-1.5 pr-1"
  defp classes(:size, %{size: "sm"}), do: "py-0.5 px-1.5"
  defp classes(:size, %{size: "md", avatar: _, delete_icon: _}), do: "pl-0 pr-1"
  defp classes(:size, %{size: "md", avatar: _}), do: "pl-0 pr-3"
  defp classes(:size, %{size: "md", icon: _, delete_icon: _}), do: "pl-1 py-1 pr-1"
  defp classes(:size, %{size: "md", icon: _}), do: "pl-1 py-1 pr-3"
  defp classes(:size, %{size: "md", delete_icon: _}), do: "py-1 pl-3 pr-1"
  defp classes(:size, %{size: "md"}), do: "py-1 px-3"

  # Variant
  defp classes(:variant, %{color: color, variant: "filled"}) do
    "bg-#{color}-300 text-#{color}-900 dark:bg-#{color}-400"
  end

  defp classes(:variant, %{color: color, variant: "outlined"}) do
    "border border-#{color}-600 text-#{color}-600 dark:border-#{color}-300 dark:text-#{color}-300"
  end

  defp classes(_rule_group, _assigns), do: nil
end
