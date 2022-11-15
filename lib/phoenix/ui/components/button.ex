defmodule Phoenix.UI.Components.Button do
  @moduledoc """
  Provides button component.
  """
  use Phoenix.UI, :component

  attr(:color, :string, default: "blue", values: Theme.colors())
  attr(:element, :string, default: "button")
  attr(:extend_class, :string)
  attr(:rest, :global, include: ~w(disabled form name value))
  attr(:size, :string, default: "md", values: ["xs", "sm", "md", "lg"])
  attr(:square, :boolean, default: false)
  attr(:variant, :string, default: "contained", values: ["contained", "icon", "outlined", "text"])

  slot(:inner_block, required: true)

  @doc """
  Renders button component.

  ## Examples

      ```
      <.button>
        Click me
      </.button>
      ```

  """
  @spec button(Socket.assigns()) :: Rendered.t()
  def button(prev_assigns) do
    prev_assigns
    |> assign_class(~w(
      button tracking-wider uppercase outline-none focus:outline-none text-center transition
      duration-200 ease-in-out disabled:opacity-50 disabled:cursor-not-allowed
      #{classes(:color, prev_assigns)}
      #{classes(:size, prev_assigns)}
      #{classes(:square, prev_assigns)}
      #{classes(:variant, prev_assigns)}
    ))
    |> render_btn()
  end

  ### Btn Markup ##########################

  defp render_btn(%{href: _} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp render_btn(%{navigate: _} = assigns) do
    ~H"""
    <.link class={@class} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp render_btn(%{patch: _} = assigns) do
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

  # Size
  defp classes(:size, %{size: "xs", variant: "icon"}), do: "p-1 text-xs"
  defp classes(:size, %{size: "sm", variant: "icon"}), do: "p-2 text-xs"
  defp classes(:size, %{variant: "icon"}), do: "p-3 text-xs"
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
