defmodule Phoenix.UI.Components.Button do
  @moduledoc """
  Provides button component.
  """
  use Phoenix.UI, :component

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
  Renders button component.

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
      #{classes(:color, assigns)}
      #{classes(:full_width, assigns)}
      #{classes(:size, assigns)}
      #{classes(:square, assigns)}
      #{classes(:variant, assigns)}
    ))
    |> render_btn()
  end

  ### Btn Markup ##########################

  defp render_btn(%{rest: %{href: _}} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp render_btn(%{rest: %{navigate: _}} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp render_btn(%{rest: %{patch: _}} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp render_btn(assigns) do
    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### CSS Classes ##########################

  # Color
  defp classes(:color, %{color: color, variant: "contained"}) do
    "bg-#{color}-500 hover:bg-#{color}-700 disabled:hover:bg-#{color}-500"
  end

  defp classes(:color, %{color: color, variant: "icon"}) do
    "text-#{color}-500 hover:text-#{color}-700 dark:hover:text-#{color}-300 hover:bg-#{color}-500/20 disabled:bg-transparent disabled:text-#{color}-500"
  end

  defp classes(:color, %{color: color, variant: "outlined"}) do
    "text-#{color}-500 border-#{color}-500 hover:text-#{color}-700 hover:border-#{color}-700 hover:bg-#{color}-700/20 disabled:bg-transparent disabled:border-#{color}-500 disabled:text-#{color}-500"
  end

  defp classes(:color, %{color: color, variant: "text"}) do
    "text-#{color}-500 dark:text-#{color}-400 hover:text-#{color}-700 hover:bg-#{color}-500/20 disabled:bg-transparent disabled:text-#{color}-500"
  end

  # Full Width
  defp classes(:full_width, %{full_width: true}), do: "w-full"

  # Size
  defp classes(:size, %{size: "xs", variant: "icon"}), do: "p-1 text-xs"
  defp classes(:size, %{size: "sm", variant: "icon"}), do: "p-2 text-xs"
  defp classes(:size, %{variant: "icon"}), do: "p-3 text-xs"
  defp classes(:size, %{size: "xs"}), do: "py-1 px-1.5 text-xs"
  defp classes(:size, %{size: "sm"}), do: "py-2 px-3 text-xs"
  defp classes(:size, %{size: "md"}), do: "py-2 px-4 text-base font-semibold"
  defp classes(:size, %{size: "lg"}), do: "py-3 px-5 text-xl font-bold"

  # Square
  defp classes(:square, %{variant: "icon"}), do: "rounded-full"
  defp classes(:square, %{square: false}), do: "rounded"

  # Variant
  defp classes(:variant, %{variant: "contained"}), do: "text-white shadow"
  defp classes(:variant, %{variant: "outlined"}), do: "bg-transparent border border-solid"
  defp classes(:variant, %{variant: "text"}), do: "bg-transparent"

  defp classes(_rule_group, _assigns), do: nil
end
