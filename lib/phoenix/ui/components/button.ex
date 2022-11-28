defmodule Phoenix.UI.Components.Button do
  @moduledoc """
  Provides button-related components.
  """
  use Phoenix.UI, :component

  ### Button ##########################

  attr(:class, :string, doc: "Override the classes applied to the component.")

  attr(:color, :string,
    default: "blue",
    doc: "The color of the component.",
    values: Theme.colors()
  )

  attr(:element, :string, default: "button", doc: "The HTML element to use, such as `div`.")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")

  attr(:full_width, :boolean,
    doc: "If true, the component will take up the full width of its container."
  )

  attr(:rest, :global,
    doc: "Arbitrary HTML or phx attributes",
    include:
      ~w(csrf_token disabled download form href hreflang method name navigate patch referrerpolicy rel replace target type value)
  )

  attr(:size, :string,
    default: "md",
    doc: "The size of the component.",
    values: ["xs", "sm", "md", "lg"]
  )

  attr(:square, :boolean, default: false, doc: "If true, rounded corners are disabled.")

  attr(:variant, :string,
    default: "contained",
    doc: "The variant to use.",
    values: ["contained", "icon", "outlined", "text"]
  )

  slot(:inner_block, required: true)

  @doc """
  A button triggers an event or action. They let users know what will happen next.

  ## Examples

      <.button>
        Click me
      </.button>

  """
  @spec button(Socket.assigns()) :: Rendered.t()
  def button(assigns) do
    assigns
    |> assign_class(~w(
      button tracking-wider uppercase outline-none focus:outline-none text-center transition
      duration-200 ease-in-out disabled:opacity-50 disabled:cursor-not-allowed
      #{btn_classes(:color, assigns)}
      #{btn_classes(:full_width, assigns)}
      #{btn_classes(:size, assigns)}
      #{btn_classes(:square, assigns)}
      #{btn_classes(:variant, assigns)}
    ))
    |> btn_markup()
  end

  defp btn_markup(%{rest: %{href: _}} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp btn_markup(%{rest: %{navigate: _}} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp btn_markup(%{rest: %{patch: _}} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp btn_markup(assigns) do
    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  # Color
  defp btn_classes(:color, %{color: color, variant: "contained"}) do
    "bg-#{color}-500 hover:bg-#{color}-700 disabled:hover:bg-#{color}-500"
  end

  defp btn_classes(:color, %{color: color, variant: "icon"}) do
    "text-#{color}-500 hover:text-#{color}-700 dark:hover:text-#{color}-300 hover:bg-#{color}-500/20 disabled:bg-transparent disabled:text-#{color}-500"
  end

  defp btn_classes(:color, %{color: color, variant: "outlined"}) do
    "text-#{color}-500 border-#{color}-500 hover:text-#{color}-700 hover:border-#{color}-700 hover:bg-#{color}-700/20 disabled:bg-transparent disabled:border-#{color}-500 disabled:text-#{color}-500"
  end

  defp btn_classes(:color, %{color: color, variant: "text"}) do
    "text-#{color}-500 dark:text-#{color}-400 hover:text-#{color}-700 hover:bg-#{color}-500/20 disabled:bg-transparent disabled:text-#{color}-500"
  end

  # Full Width
  defp btn_classes(:full_width, %{full_width: true}), do: "w-full"

  # Size
  defp btn_classes(:size, %{size: "xs", variant: "icon"}), do: "p-1 text-xs"
  defp btn_classes(:size, %{size: "sm", variant: "icon"}), do: "p-2 text-xs"
  defp btn_classes(:size, %{variant: "icon"}), do: "p-3 text-xs"
  defp btn_classes(:size, %{size: "xs"}), do: "py-1 px-1.5 text-xs"
  defp btn_classes(:size, %{size: "sm"}), do: "py-2 px-3 text-xs"
  defp btn_classes(:size, %{size: "md"}), do: "py-2 px-4 text-base font-semibold"
  defp btn_classes(:size, %{size: "lg"}), do: "py-3 px-5 text-xl font-bold"

  # Square
  defp btn_classes(:square, %{variant: "icon"}), do: "rounded-full"
  defp btn_classes(:square, %{square: false}), do: "rounded"

  # Variant
  defp btn_classes(:variant, %{variant: "contained"}), do: "text-white shadow"
  defp btn_classes(:variant, %{variant: "outlined"}), do: "bg-transparent border border-solid"
  defp btn_classes(:variant, %{variant: "text"}), do: "bg-transparent"

  defp btn_classes(_rule_group, _assigns), do: nil

  ### Button Group ##########################

  attr(:color, :string, default: "blue", values: Theme.colors())
  attr(:element, :string, default: "div")
  attr(:orientation, :string, default: "horizontal", values: ["horizontal", "vertical"])
  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")
  attr(:size, :string, default: "md", values: ["xs", "sm", "md", "lg"])
  attr(:square, :boolean, default: false)
  attr(:variant, :string, default: "contained", values: ["contained", "icon", "outlined", "text"])

  slot(:button)

  @doc """
  A button group gives users access to frequently performed, related actions.

  ## Examples

      <.button_group>
        <:button>
          One
        </:button>
        <:button>
          Two
        </:button>
        ...
      </.button>

  """
  @spec button_group(Socket.assigns()) :: Rendered.t()
  def button_group(assigns) do
    assigns =
      assigns
      |> assign_class(~w(
        button-group inline-flex overflow-hidden
        #{btn_group_classes(:wrapper, :color, assigns)}
        #{btn_group_classes(:wrapper, :orientation, assigns)}
        #{btn_group_classes(:wrapper, :square, assigns)}
      ))
      |> normalize_button_group_buttons()

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= for button <- @button do %>
        <.button {button}>
          <%= render_slot(button) %>
        </.button>
      <% end %>
    </.dynamic_tag>
    """
  end

  defp normalize_button_group_buttons(assigns) do
    buttons =
      assigns
      |> Map.get(:button, [])
      |> Enum.map(fn button ->
        extend_class = build_class(~w(
          button-group-button
          #{btn_group_classes(:button, :border, assigns)}
          #{Map.get(assigns, :extend_class)}
        ))

        button
        |> Map.put_new(:color, assigns[:color])
        |> Map.put_new(:size, assigns[:size])
        |> Map.put_new(:type, assigns[:type])
        |> Map.put_new(:variant, assigns[:variant])
        |> Map.put(:extend_class, extend_class)
        |> Map.put(:square, true)
      end)

    assign(assigns, :button, buttons)
  end

  # Wrapper - Color
  defp btn_group_classes(:wrapper, :color, %{color: color, variant: "contained"}) do
    "border border-#{color}-600"
  end

  defp btn_group_classes(:wrapper, :color, %{color: color, variant: "outlined"}) do
    "border border-#{color}-500"
  end

  # Wrapper - Orientation
  defp btn_group_classes(:wrapper, :orientation, %{orientation: "vertical"}), do: "flex-col"

  # Wrapper - Square
  defp btn_group_classes(:wrapper, :square, %{square: false}), do: "rounded"

  # Button - Border
  defp btn_group_classes(:button, :border, %{color: color, orientation: "horizontal"}) do
    "border-0 border-l first:border-l-0 border-#{color}-600"
  end

  defp btn_group_classes(:button, :border, %{color: color, orientation: "vertical"}) do
    "border-0 border-t first:border-t-0 border-#{color}-600"
  end

  defp btn_group_classes(_element, _rule_group, _assigns), do: nil
end
