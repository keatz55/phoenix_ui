defmodule PhoenixUI.Components.Badge do
  @moduledoc """
  Provides badge component.
  """
  use PhoenixUI, :component

  @default_border false
  @default_color "blue"
  @default_invisible false
  @default_position "top_end"
  @default_variant "standard"

  @doc """
  Renders badge component.

  ## Examples

      ```
      <.badge content="99+">
        <.heroicon name="mail" />
      </.badge>
      ```

  """
  @spec badge(Socket.assigns()) :: Rendered.t()
  def badge(raw) do
    assigns =
      raw
      |> assign_new(:border, fn -> @default_border end)
      |> assign_new(:color, fn -> @default_color end)
      |> assign_new(:invisible, fn -> @default_invisible end)
      |> assign_new(:position, fn -> @default_position end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_badge_attrs()
      |> build_wrapper_attrs()

    ~H"""
    <div {@wrapper_attrs}>
      <%= render_slot(@inner_block) %>
      <%= if assigns[:content] do %>
        <div {@badge_attrs}>
          <%= if @variant != "dot" do %>
            <%= if is_bitstring(@content) do %>
              <%= @content %>
            <% else %>
              <%= render_slot(@content) %>
            <% end %>
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  ### Wrapper Attrs ##########################

  defp build_wrapper_attrs(assigns) do
    wrapper = Map.get(assigns, :wrapper, [])

    class = build_class(~w(
      badge-wrapper relative inline-block
      #{Keyword.get(wrapper, :extend_class)}
    ))

    attrs =
      wrapper
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put_new(:class, class)

    assign(assigns, :wrapper_attrs, attrs)
  end

  ### Badge Attrs ##########################

  defp build_badge_attrs(assigns) do
    class = build_class(~w(
      badge inline-block z-50 absolute text-xs text-white rounded-full
      text-center transition-all ease-in-out duration-300
      #{classes(:border, assigns)}
      #{classes(:color, assigns)}
      #{classes(:invisible, assigns)}
      #{classes(:position, assigns)}
      #{classes(:variant, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:color, :content, :id, :position, :variant, :wrapper])
      |> Keyword.put_new(:class, class)

    assign(assigns, :badge_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Border
  defp classes(:border, %{border: true}), do: "border-2 border-white dark:border-slate-900"

  # Color
  defp classes(:color, %{color: color}), do: "bg-#{color}-600"

  # Color
  defp classes(:invisible, %{invisible: true}), do: "invisible"

  # Position
  defp classes(:position, %{position: "bottom_end"}), do: "top-2/3 left-2/3"
  defp classes(:position, %{position: "bottom_start"}), do: "top-2/3 right-2/3"
  defp classes(:position, %{position: "bottom"}), do: "top-2/3 left-1/2 -translate-x-1/2"
  defp classes(:position, %{position: "left_end"}), do: "right-2/3 top-2/3"
  defp classes(:position, %{position: "left_start"}), do: "right-2/3 bottom-2/3"
  defp classes(:position, %{position: "left"}), do: "right-2/3 top-1/2 -translate-y-1/2"
  defp classes(:position, %{position: "right_end"}), do: "left-2/3 top-2/3"
  defp classes(:position, %{position: "right_start"}), do: "left-2/3 bottom-2/3"
  defp classes(:position, %{position: "right"}), do: "left-2/3 top-1/2 -translate-y-1/2"
  defp classes(:position, %{position: "top_end"}), do: "bottom-2/3 left-2/3"
  defp classes(:position, %{position: "top_start"}), do: "bottom-2/3 right-2/3"
  defp classes(:position, %{position: "top"}), do: "bottom-2/3 left-1/2 -translate-x-1/2"

  # Color
  defp classes(:variant, %{variant: "dot"}), do: "p-[0.3rem]"
  defp classes(:variant, %{variant: "standard"}), do: "py-0.5 px-1.5"

  defp classes(_rule_group, _assigns), do: nil
end
