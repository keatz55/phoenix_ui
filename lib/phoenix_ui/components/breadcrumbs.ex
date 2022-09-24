defmodule PhoenixUI.Components.Breadcrumbs do
  @moduledoc """
  Provides breadcrumbs component.
  """
  import PhoenixUI.Components.{Heroicon, A}

  use PhoenixUI, :component

  @default_a_color "slate"
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
      |> normalize_as()

    ~H"""
    <nav {@nav_attrs}>
      <ol class="flex items-center space-x-2" role="list">
        <%= for a <- @a do %>
          <li class="flex items-center">
            <.a {a}>
              <%= render_slot(a) %>
            </.a>
            <%= if !a[:"aria-current"] do %>
              <.heroicon {@separator_attrs} />
            <% end %>
          </li>
        <% end %>
      </ol>
    </nav>
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
    generate_all_classes(&breadcrumbs/1,
      a: [
        [
          %{inner_block: fn _, _ -> "Phoenix UI" end},
          %{inner_block: fn _, _ -> "Components" end}
        ]
      ]
    )
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

  defp normalize_as(assigns) do
    as =
      assigns
      |> Map.get(:a, [])
      |> Enum.reverse()
      |> Enum.reduce([], fn a, acc ->
        updated = a |> Map.put_new(:color, @default_a_color) |> apply_aria_current(acc)
        [updated | acc]
      end)

    assign(assigns, :a, as)
  end

  defp apply_aria_current(a, []), do: Map.put(a, :"aria-current", "page")
  defp apply_aria_current(a, _acc), do: a
end
