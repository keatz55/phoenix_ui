defmodule Phoenix.UI.Components.TextFilter do
  @moduledoc """
  Provides text filter component.
  """
  import Phoenix.UI.Components.TextField

  use Phoenix.UI, :live_component

  @default_change_event "handle_change"
  @default_debounce 300
  @default_start_icon %{name: "magnifying-glass"}
  @default_variant "simple"

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form
        :let={f}
        for={:filter}
        id={"#{@id}_form"}
        phx-change="handle_change"
        phx-submit="handle_change"
        phx-target={@myself}
      >
        <.text_field
          end_icon={@end_icon}
          extend_class={@extend_class}
          field={{f, :text}}
          full_width={@full_width}
          margin={@margin}
          phx-debounce={assigns[:"phx-debounce"]}
          start_icon={@start_icon}
          value={@value}
          variant={@variant}
        />
      </.form>
    </div>
    """
  end

  @impl true
  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
      |> assign_new(:"phx-change", fn -> @default_change_event end)
      |> assign_new(:"phx-debounce", fn -> @default_debounce end)
      |> assign_new(:"phx-submit", fn -> @default_change_event end)
      |> assign_new(:"phx-target", fn -> socket.assigns.myself end)
      |> assign_new(:extend_class, fn -> nil end)
      |> assign_new(:full_width, fn -> true end)
      |> assign_new(:margin, fn -> "none" end)
      |> assign_new(:start_icon, fn -> @default_start_icon end)
      |> assign_new(:value, fn -> assigns[:default_value] end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> assign_end_icon()
    }
  end

  @impl true
  def handle_event("handle_change", %{"filter" => %{"text" => value}}, socket) do
    {:noreply, socket.assigns.on_change.(value, socket)}
  end

  defp assign_end_icon(%Socket{assigns: %{value: val} = assigns} = socket) do
    end_icon =
      if val in [nil, ""] do
        nil
      else
        %{
          "phx-click": JS.push(assigns[:"phx-change"], value: %{"filter" => %{"text" => ""}}),
          "phx-target": assigns[:"phx-target"],
          extend_class: "cursor-pointer",
          name: "x-mark"
        }
      end

    assign(socket, :end_icon, end_icon)
  end
end
