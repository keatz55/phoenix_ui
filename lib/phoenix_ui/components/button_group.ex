defmodule PhoenixUI.Components.ButtonGroup do
  @moduledoc """
  Provides a button_group component.
  """
  import PhoenixUI.Components.Button, only: [button: 1]

  use PhoenixUI, :component

  attr(:color, :string, default: "blue")
  attr(:disabled, :boolean, default: true)
  attr(:element, :string, default: "div")
  attr(:orientation, :string, default: "horizontal")
  attr(:size, :string, default: "md")
  attr(:square, :boolean, default: false)
  attr(:type, :string, default: "button")
  attr(:variant, :string, default: "contained")

  @doc """
  Renders a button group

  ## Examples

      ```
      <.button_group>
        <:button>
          One
        </:button>
        <:button>
          Two
        </:button>
        ...
      </.button>
      ```

  """
  @spec button_group(Socket.assigns()) :: Rendered.t()
  def button_group(prev_assigns) do
    assigns = prev_assigns |> build_wrapper_attrs() |> normalize_buttons()

    ~H"""
    <.dynamic_tag {@wrapper_attrs}>
      <%= for button <- @button do %>
        <.button {button}>
          <%= render_slot(button) %>
        </.button>
      <% end %>
    </.dynamic_tag>
    """
  end

  ### Wrapper Attrs ##########################

  defp build_wrapper_attrs(assigns) do
    class = build_class(~w(
      button-group inline-flex overflow-hidden
      #{classes(:wrapper, :color, assigns)}
      #{classes(:wrapper, :orientation, assigns)}
      #{classes(:wrapper, :square, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:button, :color, :extend_class, :size, :variant])
      |> Keyword.put_new(:class, class)
      |> Keyword.put_new(:name, assigns[:element])

    assign(assigns, :wrapper_attrs, attrs)
  end

  ### Normalize Buttons ##########################

  defp normalize_buttons(assigns) do
    buttons =
      assigns
      |> Map.get(:button, [])
      |> Enum.map(fn button ->
        extend_class = build_class(~w(
          button-group-button
          #{classes(:button, :border, assigns)}
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

  ### CSS Classes ##########################

  # Wrapper - Color
  defp classes(:wrapper, :color, %{color: color, variant: "contained"}) do
    "border border-#{color}-600"
  end

  defp classes(:wrapper, :color, %{color: color, variant: "outlined"}) do
    "border border-#{color}-500"
  end

  # Wrapper - Orientation
  defp classes(:wrapper, :orientation, %{orientation: "vertical"}), do: "flex-col"

  # Wrapper - Square
  defp classes(:wrapper, :square, %{square: false}), do: "rounded"

  # Button - Border
  defp classes(:button, :border, %{color: color, orientation: "horizontal"}) do
    "border-0 border-l first:border-l-0 border-#{color}-600"
  end

  defp classes(:button, :border, %{color: color, orientation: "vertical"}) do
    "border-0 border-t first:border-t-0 border-#{color}-600"
  end

  defp classes(_element, _rule_group, _assigns), do: nil
end
