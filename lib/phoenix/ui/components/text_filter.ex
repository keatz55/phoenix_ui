defmodule Phoenix.UI.Components.TextFilter do
  @moduledoc """
  Provides text filter component.
  """
  alias Plug.Conn.Query

  import Phoenix.UI.Components.TextField

  use Phoenix.UI, :live_component

  @default_debounce 300
  @default_full_width true
  @default_handle_change "handle_change"
  @default_margin "none"
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
        phx-change={@handle_change}
        phx-submit={@handle_change}
        phx-target={assigns[:"phx-target"]}
      >
        <.text_field
          end_icon={@end_icon}
          extend_class={assigns[:extend_class]}
          field={{f, :text}}
          full_width={@full_width}
          margin={@margin}
          phx-debounce={assigns[:"phx-debounce"]}
          placeholder={assigns[:placeholder]}
          start_icon={@start_icon}
          value={assigns[:value]}
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
      |> assign_new(:"phx-debounce", fn -> @default_debounce end)
      |> assign_new(:full_width, fn -> @default_full_width end)
      |> assign_new(:margin, fn -> @default_margin end)
      |> assign_new(:start_icon, fn -> @default_start_icon end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> assign_handle_change()
      |> assign_end_icon()
    }
  end

  @impl true
  def handle_event("handle_change", %{"filter" => %{"text" => value}}, socket) do
    socket = assign(socket, :value, value)

    if is_function(socket.assigns[:on_change]) do
      {:noreply, socket.assigns.on_change.(value, socket)}
    else
      uri = socket.assigns[:uri] || URI.new("/")
      param = socket.assigns[:param] || "text_filter"

      qs =
        (uri.query || "")
        |> Query.decode()
        |> then(fn query ->
          case value do
            "" -> Map.drop(query, [param])
            value -> Map.put(query, param, value)
          end
        end)
        |> Query.encode()

      path = if qs == "", do: uri.path, else: "#{uri.path}?#{qs}"

      {:noreply, push_patch(socket, to: path, replace: true)}
    end
  end

  defp assign_handle_change(%Socket{assigns: assigns} = socket) do
    if is_bitstring(assigns[:on_change]) do
      assign(socket, :handle_change, assigns[:on_change])
    else
      assign(socket, handle_change: @default_handle_change, "phx-target": assigns.myself)
    end
  end

  defp assign_end_icon(%{assigns: assigns} = socket) do
    end_icon =
      if assigns[:value] in [nil, ""] do
        nil
      else
        %{
          "phx-click": JS.push(assigns[:handle_change], value: %{"filter" => %{"text" => ""}}),
          "phx-target": assigns[:"phx-target"],
          extend_class: "cursor-pointer",
          name: "x-mark"
        }
      end

    assign(socket, :end_icon, end_icon)
  end
end
