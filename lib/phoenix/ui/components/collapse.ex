defmodule Phoenix.UI.Components.Collapse do
  @moduledoc """
  Provides collapse component.
  """
  use Phoenix.UI, :component

  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:max_size, :string, default: "5000px")
  attr(:orientation, :string, default: "vertical", values: ["horizontal", "vertical"])
  attr(:rest, :global, include: ~w(open))
  attr(:transition_duration, :integer, default: 300)

  slot(:inner_block, required: true)

  @doc """
  Renders collapse component.

  ## Examples

      ```
      <.collapse>
        content
      </.collapse>
      ```

  """
  @spec collapse(Socket.assigns()) :: Rendered.t()
  def collapse(prev_assigns) do
    assigns = assign_class(prev_assigns, ~w(
        collapse overflow-hidden invisible open:visible transition-all ease-in-out
        #{classes(:max_size, prev_assigns)}
        #{classes(:open, prev_assigns)}
        #{classes(:transition, prev_assigns)}
      ))

    ~H"""
    <.dynamic_tag class={@class} name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  ### JS Interactions ##########################

  @doc """
  Closes collapse by selector.

  ## Examples

      iex> close_collapse(selector)
      %JS{}

      iex> close_collapse(js, selector)
      %JS{}

  """
  @spec close_collapse(String.t()) :: struct()
  def close_collapse(selector), do: close_collapse(%JS{}, selector)

  @spec close_collapse(struct(), String.t()) :: struct()
  def close_collapse(%JS{} = js, selector) do
    JS.remove_attribute(js, "open", to: selector)
  end

  @doc """
  Opens collapse by selector.

  ## Examples

      iex> open_collapse(selector)
      %JS{}

      iex> open_collapse(js, selector)
      %JS{}

  """
  @spec open_collapse(String.t()) :: struct()
  def open_collapse(selector), do: open_collapse(%JS{}, selector)

  @spec open_collapse(struct(), String.t()) :: struct()
  def open_collapse(%JS{} = js, selector) do
    JS.set_attribute(js, {"open", "true"}, to: selector)
  end

  ### CSS Classes ##########################

  # Max Size
  defp classes(:max_size, %{max_size: size, orientation: "vertical"}), do: "open:max-h-[#{size}]"

  # Open
  defp classes(:open, %{orientation: "horizontal"}), do: "max-w-0 open:max-w-full"
  defp classes(:open, %{orientation: "vertical"}), do: "max-h-0"

  # Transition
  defp classes(:transition, %{transition_duration: duration}), do: "duration-#{duration}"

  defp classes(_rule_group, _assigns), do: nil
end
