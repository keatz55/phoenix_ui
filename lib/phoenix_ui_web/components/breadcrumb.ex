defmodule PhoenixUIWeb.Components.Breadcrumb do
  @moduledoc """
  Provides breadcrumb-related components.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  import PhoenixUIWeb.CoreComponents

  @doc """
  A breadcrumbs is a list of links that help visualize a page's location
  within a site's hierarchical structure, it allows navigation up to any
  of the ancestors.

  ## Examples

  ```heex
  <.breadcrumb>
    <:item>Phoenix UI</:item>
    <:item>Core</:item>
    <:item 'aria-current="page"'>Breadcrumbs</:item>
  </.breadcrumb>
  ```
  """

  attr :class, :any, doc: "Extend existing component styles"
  attr :separator_icon, :string, default: "hero-chevron-right-mini"
  attr :rest, :global

  slot :item, required: true, validate_attrs: false

  @spec breadcrumb(Socket.assigns()) :: Rendered.t()
  def breadcrumb(assigns) do
    ~H"""
    <nav aria-label="Breadcrumb" class={["breadcrumb flex", assigns[:class]]} {@rest}>
      <ol role="list" class="flex items-center space-x-4 text-sm font-medium">
        <%= for {item, idx} <- Enum.with_index(@item) do %>
          <li :if={idx != 0} aria-hidden="true" class="text-zinc-400 dark:text-zinc-600">
            <.icon class="icon h-5 w-5" name={@separator_icon} />
          </li>
          <li class="flex items-center">
            <.link
              class={[
                "text-zinc-500 hover:text-zinc-700 dark:text-zinc-400 dark:hover:text-zinc-200 transition-colors duration-300",
                "aria-[current=page]:text-zinc-700 dark:aria-[current=page]:text-zinc-200",
                item[:class]
              ]}
              {assigns_to_attributes(item, [:class])}
            >
              {render_slot(item)}
            </.link>
          </li>
        <% end %>
      </ol>
    </nav>
    """
  end
end
