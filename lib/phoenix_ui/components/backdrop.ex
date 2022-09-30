defmodule PhoenixUI.Components.Backdrop do
  @moduledoc """
  Provides Backdrop component.
  """
  use PhoenixUI, :component

  attr(:element, :string, default: "div")
  attr(:invisible, :boolean, default: false)
  attr(:open, :boolean, default: true)
  attr(:transition_duration, :integer, default: 300)

  @doc """
  Renders backdrop component.

  ## Examples

      ```
      <.backdrop/>
      ```

  """
  @spec backdrop(Socket.assigns()) :: Rendered.t()
  def backdrop(prev_assigns) do
    assigns =
      prev_assigns
      |> assign_class(~w(
        backdrop fixed inset-0 z-50 invisible opacity-0
        open:visible open:opacity-100 transition-all ease-in-out
        #{classes(:color, prev_assigns)}
        #{classes(:transition, prev_assigns)}
      ))
      |> assign_rest([:element, :elevation, :variant])

    ~H"""
    <%= if assigns[:inner_block] do %>
      <.dynamic_tag name={@element} {@rest}>
        <%= render_slot(@inner_block) %>
      </.dynamic_tag>
    <% else %>
      <.dynamic_tag name={@element} {@rest}></.dynamic_tag>
    <% end %>
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
