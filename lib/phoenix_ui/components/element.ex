defmodule PhoenixUI.Components.Element do
  @moduledoc """
  Provides element component.
  """
  import Phoenix.HTML.Link, only: [link: 2]

  use PhoenixUI, :component

  @default_variant "div"

  @doc """
  Renders element component.

  ## Examples

      ```
      <.element variant="address">
        content
      </.element>
      ```

  """
  @spec element(Socket.assigns()) :: Rendered.t()
  def element(assigns) do
    assigns
    |> assign_new(:variant, fn -> @default_variant end)
    |> build_element_attrs()
    |> generate_markup()
  end

  ### Markup ##########################

  defp generate_markup(%{variant: "a"} = assigns) do
    ~H"""
    <a {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </a>
    """
  end

  defp generate_markup(%{variant: "address"} = assigns) do
    ~H"""
    <address {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </address>
    """
  end

  defp generate_markup(%{variant: "article"} = assigns) do
    ~H"""
    <article {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </article>
    """
  end

  defp generate_markup(%{variant: "aside"} = assigns) do
    ~H"""
    <aside {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </aside>
    """
  end

  defp generate_markup(%{variant: "button"} = assigns) do
    ~H"""
    <button {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  defp generate_markup(%{variant: "div"} = assigns) do
    ~H"""
    <div {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  defp generate_markup(%{variant: "footer"} = assigns) do
    ~H"""
    <footer {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </footer>
    """
  end

  defp generate_markup(%{variant: "h1"} = assigns) do
    ~H"""
    <h1 {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </h1>
    """
  end

  defp generate_markup(%{variant: "h2"} = assigns) do
    ~H"""
    <h2 {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </h2>
    """
  end

  defp generate_markup(%{variant: "h3"} = assigns) do
    ~H"""
    <h3 {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </h3>
    """
  end

  defp generate_markup(%{variant: "h4"} = assigns) do
    ~H"""
    <h4 {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </h4>
    """
  end

  defp generate_markup(%{variant: "h5"} = assigns) do
    ~H"""
    <h5 {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </h5>
    """
  end

  defp generate_markup(%{variant: "h6"} = assigns) do
    ~H"""
    <h6 {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </h6>
    """
  end

  defp generate_markup(%{variant: "header"} = assigns) do
    ~H"""
    <header {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </header>
    """
  end

  defp generate_markup(%{variant: "img"} = assigns) do
    ~H"""
    <img {@element_attrs} />
    """
  end

  defp generate_markup(%{variant: "li"} = assigns) do
    ~H"""
    <li {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </li>
    """
  end

  defp generate_markup(%{variant: "link"} = assigns) do
    ~H"""
    <%= link(@element_attrs) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  defp generate_markup(%{variant: "live_patch"} = assigns) do
    ~H"""
    <%= live_patch(@element_attrs) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  defp generate_markup(%{variant: "live_redirect"} = assigns) do
    ~H"""
    <%= live_redirect(@element_attrs) do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  defp generate_markup(%{variant: "main"} = assigns) do
    ~H"""
    <main {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </main>
    """
  end

  defp generate_markup(%{variant: "nav"} = assigns) do
    ~H"""
    <nav {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </nav>
    """
  end

  defp generate_markup(%{variant: "p"} = assigns) do
    ~H"""
    <p {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </p>
    """
  end

  defp generate_markup(%{variant: "section"} = assigns) do
    ~H"""
    <section {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </section>
    """
  end

  defp generate_markup(%{variant: "table"} = assigns) do
    ~H"""
    <table {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </table>
    """
  end

  defp generate_markup(%{variant: "ul"} = assigns) do
    ~H"""
    <ul {@element_attrs}>
      <%= render_slot(@inner_block) %>
    </ul>
    """
  end

  ### Element Attrs ##########################

  defp build_element_attrs(assigns) do
    class = Map.get(assigns, :extend_class, "")

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class, :variant])
      |> Keyword.put_new(:class, class)

    assign(assigns, :element_attrs, attrs)
  end
end
