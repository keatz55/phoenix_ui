defmodule Phoenix.UI.Components.Breadcrumbs do
  @moduledoc """
  Provides breadcrumbs component.
  """
  import Phoenix.UI.Components.{Heroicon, Link}

  use Phoenix.UI, :component

  @default_link_color "slate"
  @default_separator "chevron-right"

  @doc """
  Renders breadcrumbs component.

  ## Examples

      ```
      <.breadcrumbs>
        <:a href={[to: "#"]}>Users</:a>
        <:a href={[to: "#"]}>John Doe</:a>
        <:a>Edit</:a>
      </.breadcrumbs>
      ```

  """
  @spec breadcrumbs(Socket.assigns()) :: Rendered.t()
  def breadcrumbs(raw) do
    assigns =
      raw
      |> assign_new(:separator, fn -> @default_separator end)
      |> build_nav_attrs()
      |> build_separator_attrs()
      |> normalize_links()

    ~H"""
    <nav {@nav_attrs}>
      <ol class="flex items-center space-x-2" role="list">
        <%= for link <- @a do %>
          <li class="flex items-center">
            <.a {link}>
              <%= render_slot(link) %>
            </.a>
            <%= if !link[:"aria-current"] do %>
              <.heroicon {@separator_attrs} />
            <% end %>
          </li>
        <% end %>
      </ol>
    </nav>
    """
  end

  ### Nav Attrs ##########################

  defp build_nav_attrs(assigns) do
    class = build_class(~w(
      breadcrumb text-sm font-medium my-6
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class, :a, :size])
      |> Keyword.put_new(:class, class)
      |> Keyword.put_new(:"aria-label", "Breadcrumb")

    assign(assigns, :nav_attrs, attrs)
  end

  ### Separator Attrs ##########################

  defp build_separator_attrs(assigns) do
    attrs = %{
      name: assigns[:separator],
      extend_class: "ml-2",
      color: "slate"
    }

    assign(assigns, :separator_attrs, attrs)
  end

  ### Normalize Links ##########################

  defp normalize_links(assigns) do
    links =
      assigns
      |> Map.get(:a, [])
      |> Enum.reverse()
      |> Enum.reduce([], fn link, acc ->
        updated = link |> Map.put_new(:color, @default_link_color) |> apply_aria_current(acc)
        [updated | acc]
      end)

    assign(assigns, :a, links)
  end

  defp apply_aria_current(link, []), do: Map.put(link, :"aria-current", "page")
  defp apply_aria_current(link, _acc), do: link
end
