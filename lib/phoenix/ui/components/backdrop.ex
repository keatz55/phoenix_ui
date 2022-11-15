defmodule Phoenix.UI.Components.Backdrop do
  @moduledoc """
  Provides Backdrop component.
  """
  use Phoenix.UI, :component

  attr(:element, :string, default: "div")
  attr(:extend_class, :string)
  attr(:invisible, :boolean, default: false)
  attr(:rest, :global, include: ~w(open))
  attr(:transition_duration, :integer, default: 300)

  slot(:inner_block)

  @doc """
  Renders backdrop component.

  ## Examples

      ```
      <.backdrop/>
      ```

  """
  @spec backdrop(Socket.assigns()) :: Rendered.t()
  def backdrop(prev_assigns) do
    assigns = assign_class(prev_assigns, ~w(
        backdrop fixed inset-0 z-50 invisible opacity-0
        open:visible open:opacity-100 transition-all ease-in-out
        #{classes(:color, prev_assigns)}
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
  Hides backdrop by selector.

  ## Examples

      iex> hide_backdrop(selector)
      %JS{}

      iex> hide_backdrop(js, selector)
      %JS{}

  """
  @spec hide_backdrop(String.t()) :: struct()
  def hide_backdrop(selector), do: hide_backdrop(%JS{}, selector)

  @spec hide_backdrop(struct(), String.t()) :: struct()
  def hide_backdrop(%JS{} = js, selector) do
    JS.remove_attribute(js, "open", to: selector)
  end

  @doc """
  Shows backdrop by selector.

  ## Examples

      iex> show_backdrop(selector)
      %JS{}

      iex> show_backdrop(js, selector)
      %JS{}

  """
  @spec show_backdrop(String.t()) :: struct()
  def show_backdrop(selector), do: show_backdrop(%JS{}, selector)

  @spec show_backdrop(struct(), String.t()) :: struct()
  def show_backdrop(%JS{} = js, selector) do
    JS.set_attribute(js, {"open", "true"}, to: selector)
  end

  ### CSS Classes ##########################

  # Color
  defp classes(:color, %{invisible: false}), do: "bg-slate-900/70 backdrop-blur-sm"

  # Transition
  defp classes(:transition, %{transition_duration: duration}), do: "duration-#{duration}"

  defp classes(_rule_group, _assigns), do: nil
end
