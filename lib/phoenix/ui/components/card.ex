defmodule Phoenix.UI.Components.Card do
  @moduledoc """
  Provides card component.
  """
  import Phoenix.UI.Components.{Avatar, Paper, Typography}

  use Phoenix.UI, :component

  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:rest, :global)

  slot(:inner_block, required: true)

  @doc """
  Renders card component.

  ## Examples

      ```
      <.card
        elevation={3}
        square={true}
        variant="elevated"
      >
        content
      </.card>
      ```

  """
  @spec card(Socket.assigns()) :: Rendered.t()
  def card(assigns) do
    extend_class = build_class(~w(
      card overflow-hidden
      #{Map.get(assigns, :extend_class)}
    ))

    assigns = assign(assigns, :extend_class, extend_class)

    ~H"""
    <.paper extend_class={@extend_class} element={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.paper>
    """
  end

  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:rest, :global)

  slot(:action)
  slot(:avatar_group)
  slot(:avatar)
  slot(:subtitle)
  slot(:title)

  @doc """
  Renders card header component.

  ## Examples

      ```
      <.card>
        <.card_header>
          header
        </.card_header>
        ...
      </.card>
      ```

  """
  @spec card_header(Socket.assigns()) :: Rendered.t()
  def card_header(assigns) do
    assigns =
      assigns
      |> assign_class(~w(
        card-header flex items-center p-4
      ))
      |> normalize_card_header_action()
      |> normalize_card_header_avatar_group()
      |> normalize_card_header_avatar()
      |> normalize_card_header_subtitle()
      |> normalize_card_header_title()

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= for avatar <- @avatar do %>
        <.avatar {avatar} />
      <% end %>
      <%= for avatar_group <- @avatar_group do %>
        <.avatar_group {avatar_group} />
      <% end %>
      <div class="flex-1">
        <%= for title <- @title do %>
          <.typography {title}>
            <%= render_slot(title) %>
          </.typography>
        <% end %>
        <%= for subtitle <- @subtitle do %>
          <.typography {subtitle}>
            <%= render_slot(subtitle) %>
          </.typography>
        <% end %>
      </div>
      <%= for action <- @action do %>
        <%= render_slot(action) %>
      <% end %>
    </.dynamic_tag>
    """
  end

  attr(:element, :string, default: "img")
  attr(:extend_class, :string)
  attr(:rest, :global)

  @doc """
  Renders card media component.

  ## Examples

      ```
      <.card>
        ...
        <.card_media/>
        ...
      </.card>
      ```

  """
  @spec card_media(Socket.assigns()) :: Rendered.t()
  def card_media(assigns) do
    assigns = assign_class(assigns, ~w(
        card-media block bg-cover bg-no-repeat bg-center object-cover w-full
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest} />
    """
  end

  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:rest, :global)

  @doc """
  Renders card content component.

  ## Examples

      ```
      <.card>
        ...
        <.card_content>
          content
        </.card_content>
        ...
      </.card>
      ```

  """
  @spec card_content(Socket.assigns()) :: Rendered.t()
  def card_content(assigns) do
    assigns = assign_class(assigns, ~w(
        card-content p-4
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:rest, :global)

  @doc """
  Renders card actions component.

  ## Examples

      ```
      <.card>
        ...
        <.card_action>
          content
        </.card_action>
        ...
      </.card>
      ```

  """
  @spec card_action(Socket.assigns()) :: Rendered.t()
  def card_action(assigns) do
    assigns = assign_class(assigns, ~w(
        card-action p-4
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### Normalize Card Header Avatar Group ##########################

  defp normalize_card_header_avatar_group(%{avatar_group: [avatar_group | _]} = assigns) do
    extend_class = build_class(~w(
      card-header-avatar_group mr-4
      #{Map.get(avatar_group, :extend_class)}
    ))

    assign(assigns, :avatar_group, [Map.put(avatar_group, :extend_class, extend_class)])
  end

  defp normalize_card_header_avatar_group(assigns), do: assigns

  ### Normalize Card Header Avatar ##########################

  defp normalize_card_header_avatar(%{avatar: [avatar | _]} = assigns) do
    extend_class = build_class(~w(
      card-header-avatar mr-4
      #{Map.get(avatar, :extend_class)}
    ))

    assign(assigns, :avatar, [Map.put(avatar, :extend_class, extend_class)])
  end

  defp normalize_card_header_avatar(assigns), do: assigns

  ### Normalize Card Header Title ##########################

  defp normalize_card_header_title(%{title: [title | _]} = assigns) do
    extend_class = build_class(~w(
      card-header-title
      #{Map.get(title, :extend_class)}
    ))

    slot =
      title
      |> Map.put_new(:align, "left")
      |> Map.put_new(:margin, false)
      |> Map.put_new(:variant, "p")
      |> Map.put_new(:element, "h3")
      |> Map.put(:extend_class, extend_class)

    assign(assigns, :title, [slot])
  end

  defp normalize_card_header_title(assigns), do: assigns

  ### Normalize Card Header Subtitle ##########################

  defp normalize_card_header_subtitle(%{subtitle: [subtitle | _]} = assigns) do
    extend_class = build_class(~w(
      card-header-subtitle
      #{Map.get(subtitle, :extend_class)}
    ))

    slot =
      subtitle
      |> Map.put_new(:align, "left")
      |> Map.put_new(:margin, false)
      |> Map.put_new(:variant, "p")
      |> Map.put(:extend_class, extend_class)

    assign(assigns, :subtitle, [slot])
  end

  defp normalize_card_header_subtitle(assigns), do: assigns

  ### Normalize Card Header Action ##########################

  defp normalize_card_header_action(%{action: [action | _]} = assigns) do
    assign(assigns, :action, [action])
  end

  defp normalize_card_header_action(assigns), do: assigns
end
