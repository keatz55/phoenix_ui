defmodule PhoenixUI.Components.Accordion do
  @moduledoc """
  Provides accordion component.
  """
  import PhoenixUI.{Components.Collapse, Components.Heroicon}

  use PhoenixUI, :component

  @default_icon_color "slate"
  @default_icon_name_closed "chevron-up"
  @default_icon_name_opened "chevron-down"
  @default_open false
  @default_panel_variant "vertical"

  @doc """
  Renders accordion component.

  ## Examples

      ```
      <.accordion>
        <:header>
          Collapsible Item #1
        </:header>
        <:panel>
          Collapsible content
        </:panel>
      </.accordion>
      ```

  """
  @spec accordion(Socket.assigns()) :: Rendered.t()
  def accordion(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:open, fn -> @default_open end)
      |> assign(:icon_wrapper_class, "absolute right-0 top-1/2 -translate-y-1/2 cursor-pointer")
      |> build_container_attrs()
      |> build_header_closed_attrs()
      |> build_header_opened_attrs()
      |> build_icon_closed_attrs()
      |> build_icon_opened_attrs()
      |> build_panel_attrs()

    ~H"""
    <div {@container_attrs}>
      <div {@header_closed_attrs} phx-click={close_accordion(@id)}>
        <%= render_slot(@header) %>
        <div class={@icon_wrapper_class}>
          <.heroicon {@icon_closed_attrs} />
        </div>
      </div>
      <div {@header_opened_attrs} phx-click={open_accordion(@id)}>
        <%= render_slot(@header) %>
        <div class={@icon_wrapper_class}>
          <.heroicon {@icon_opened_attrs} />
        </div>
      </div>
      <.collapse {@panel_attrs}>
        <%= render_slot(@panel) %>
      </.collapse>
    </div>
    """
  end

  ### JS Interactions ##########################

  @doc """
  Closes accordion by selector.

  ## Examples

      iex> close_accordion(selector)
      %JS{}

      iex> close_accordion(js, selector)
      %JS{}

  """
  @spec close_accordion(String.t()) :: struct()
  def close_accordion(selector), do: close_accordion(%JS{}, selector)

  @spec close_accordion(struct(), String.t()) :: struct()
  def close_accordion(%JS{} = js, selector) do
    js
    |> JS.hide(to: "##{selector} .accordion-header.closed", time: 0)
    |> JS.show(to: "##{selector} .accordion-header.opened", time: 0)
    |> close_collapse("##{selector} .accordion-panel")
  end

  @doc """
  Opens accordion by selector.

  ## Examples

      iex> open_accordion(selector)
      %JS{}

      iex> open_accordion(js, selector)
      %JS{}

  """
  @spec open_accordion(String.t()) :: struct()
  def open_accordion(selector), do: open_accordion(%JS{}, selector)

  @spec open_accordion(struct(), String.t()) :: struct()
  def open_accordion(%JS{} = js, selector) do
    js
    |> JS.hide(to: "##{selector} .accordion-header.opened", time: 0)
    |> JS.show(to: "##{selector} .accordion-header.closed", time: 0)
    |> open_collapse("##{selector} .accordion-panel")
  end

  ### Container Attrs ##########################

  defp build_container_attrs(assigns) do
    class = build_class(~w(
      accordion
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:close_icon, :extend_class, :header, :open_icon, :open, :panel])
      |> Keyword.put_new(:class, class)

    assign(assigns, :container_attrs, attrs)
  end

  ### Header Attrs (Closed) ##########################

  defp build_header_closed_attrs(%{header: [header]} = assigns) do
    class = build_class(~w(
      accordion-header closed relative cursor-pointer
      #{classes(:header_closed, :open, assigns)}
      #{Map.get(header, :extend_class)}
    ))

    attrs =
      header
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put_new(:class, class)

    assign(assigns, :header_closed_attrs, attrs)
  end

  ### Header Attrs (Open) ##########################

  defp build_header_opened_attrs(%{header: [header]} = assigns) do
    class = build_class(~w(
      accordion-header opened relative cursor-pointer
      #{classes(:header_opened, :open, assigns)}
      #{Map.get(header, :extend_class)}
    ))

    attrs =
      header
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put_new(:class, class)

    assign(assigns, :header_opened_attrs, attrs)
  end

  ### Icon Attrs (Closed) ##########################

  defp build_icon_closed_attrs(assigns) do
    icon = Map.get(assigns, :open_icon, [])

    extend_class = build_class(~w(
      accordion-header-icon
      #{Keyword.get(icon, :extend_class)}
    ))

    attrs =
      icon
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put_new(:extend_class, extend_class)
      |> Keyword.put_new(:color, @default_icon_color)
      |> Keyword.put_new(:name, @default_icon_name_closed)

    assign(assigns, :icon_closed_attrs, attrs)
  end

  ### Icon Attrs (Opened) ##########################

  defp build_icon_opened_attrs(assigns) do
    icon = Map.get(assigns, :close_icon, [])

    extend_class = build_class(~w(
      accordion-header-icon
      #{Keyword.get(icon, :extend_class)}
    ))

    attrs =
      icon
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put_new(:extend_class, extend_class)
      |> Keyword.put_new(:color, @default_icon_color)
      |> Keyword.put_new(:name, @default_icon_name_opened)

    assign(assigns, :icon_opened_attrs, attrs)
  end

  ### Panel Attrs ##########################

  defp build_panel_attrs(%{panel: [panel]} = assigns) do
    extend_class = build_class(~w(
      accordion-panel
      #{Map.get(panel, :extend_class)}
    ))

    attrs =
      panel
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put_new(:variant, @default_panel_variant)
      |> Keyword.put(:extend_class, extend_class)
      |> Keyword.put(:open, Map.get(assigns, :open))

    assign(assigns, :panel_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Header (Open) - Open
  defp classes(:header_closed, :open, %{open: false}), do: "hidden"

  # Header (Closed) - Open
  defp classes(:header_opened, :open, %{open: true}), do: "hidden"

  defp classes(_element, _rule_group, _assigns), do: nil
end
