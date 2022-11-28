defmodule Phoenix.UI.Components.Tooltip do
  @moduledoc """
  Provides tooltip component.
  """
  use Phoenix.UI, :component

  attr(:class, :string, doc: "Override the classes applied to the component.")

  attr(:color, :string,
    default: "slate",
    doc: "The color of the component.",
    values: Theme.colors()
  )

  attr(:content, :string, default: nil)
  attr(:element, :string, default: "div", doc: "The HTML element to use, such as `div`.")
  attr(:extend_class, :string, doc: "Extend existing classes applied to the component.")

  attr(:position, :string,
    default: "top",
    values: [
      "bottom_end",
      "bottom_start",
      "bottom",
      "left_end",
      "left_start",
      "left",
      "right_end",
      "right_start",
      "right",
      "top_end",
      "top_start",
      "top"
    ]
  )

  attr(:rest, :global, doc: "Arbitrary HTML or phx attributes")
  attr(:variant, :string, default: "simple", values: ["arrow", "simple"])

  slot(:custom)
  slot(:inner_block)

  @doc """
  A tooltip is a floating, non-actionable label used to explain a user interface element or feature.

  ## Examples

      <.tooltip>
        content
      </.tooltip>

  """
  @spec tooltip(Socket.assigns()) :: Rendered.t()
  def tooltip(assigns) do
    assigns = assign_class(assigns, ~w(
      tooltip z-50 invisible opacity-0 group-hover:visible group-hover:opacity-100 absolute text-xs rounded
      text-center whitespace-nowrap py-1 px-2 transition-all ease-in-out delay-150 duration-300
      #{classes(:color, assigns)}
      #{classes(:margin, assigns)}
      #{classes(:position, assigns)}
      #{classes(:variant, assigns)}
    ))

    ~H"""
    <div id={assigns[:id]} class="tooltip-wrapper group relative inline-block">
      <%= render_slot(@inner_block) %>
      <.dynamic_tag class={@class} name={@element} {@rest}>
        <%= if is_bitstring(@content) do %>
          <%= @content %>
        <% else %>
          <%= render_slot(@custom) %>
        <% end %>
      </.dynamic_tag>
    </div>
    """
  end

  # Color
  defp classes(:color, %{color: color}), do: "bg-#{color}-800 text-#{color}-200"

  # Margin
  defp classes(:margin, %{position: "bottom_end"}), do: "mt-3"
  defp classes(:margin, %{position: "bottom_start"}), do: "mt-3"
  defp classes(:margin, %{position: "bottom"}), do: "mt-3"
  defp classes(:margin, %{position: "left_end"}), do: "mr-3"
  defp classes(:margin, %{position: "left_start"}), do: "mr-3"
  defp classes(:margin, %{position: "left"}), do: "mr-3"
  defp classes(:margin, %{position: "right_end"}), do: "ml-3"
  defp classes(:margin, %{position: "right_start"}), do: "ml-3"
  defp classes(:margin, %{position: "right"}), do: "ml-3"
  defp classes(:margin, %{position: "top_end"}), do: "mb-3"
  defp classes(:margin, %{position: "top_start"}), do: "mb-3"
  defp classes(:margin, %{position: "top"}), do: "mb-3"

  # Position
  defp classes(:position, %{position: "bottom_end"}), do: "top-full right-0"
  defp classes(:position, %{position: "bottom_start"}), do: "top-full left-0"
  defp classes(:position, %{position: "bottom"}), do: "top-full left-1/2 -translate-x-1/2"
  defp classes(:position, %{position: "left_end"}), do: "right-full bottom-0"
  defp classes(:position, %{position: "left_start"}), do: "right-full top-0"
  defp classes(:position, %{position: "left"}), do: "right-full top-1/2 -translate-y-1/2"
  defp classes(:position, %{position: "right_end"}), do: "left-full bottom-0"
  defp classes(:position, %{position: "right_start"}), do: "left-full top-0"
  defp classes(:position, %{position: "right"}), do: "left-full top-1/2 -translate-y-1/2"
  defp classes(:position, %{position: "top_end"}), do: "bottom-full right-0"
  defp classes(:position, %{position: "top_start"}), do: "bottom-full left-0"
  defp classes(:position, %{position: "top"}), do: "bottom-full left-1/2 -translate-x-1/2"

  # Variant
  defp classes(:variant, %{color: color, position: position, variant: "arrow"}) do
    case position do
      pos when pos in ["bottom_end", "bottom_start", "bottom"] ->
        "after:absolute after:-top-1.5 after:left-1/2 after:-translate-x-1/2 after:border-solid after:border-b-8 after:border-x-transparent after:border-x-8 after:border-t-0 after:border-b-#{color}-800"

      pos when pos in ["left_end", "left_start", "left"] ->
        "after:absolute after:-right-1.5 after:top-1/2 after:-translate-y-1/2 after:border-solid after:border-l-8 after:border-y-transparent after:border-y-8 after:border-r-0 after:border-l-#{color}-800"

      pos when pos in ["right_end", "right_start", "right"] ->
        "after:absolute after:-left-1.5 after:top-1/2 after:-translate-y-1/2 after:border-solid after:border-r-8 after:border-y-transparent after:border-y-8 after:border-l-0 after:border-r-#{color}-800"

      pos when pos in ["top_end", "top_start", "top"] ->
        "after:absolute after:-bottom-1.5 after:left-1/2 after:-translate-x-1/2 after:border-solid after:border-t-8 after:border-x-transparent after:border-x-8 after:border-b-0 after:border-t-#{color}-800"
    end
  end

  defp classes(_rule_group, _assigns), do: nil
end
