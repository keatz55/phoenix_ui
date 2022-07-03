defmodule PhoenixUI.Components.DescriptionList do
  @moduledoc """
  Provides description list component.
  """
  use PhoenixUI, :component

  @default_variant :simple
  @default_striped false

  @doc """
  Renders description list component.

  ## Examples

      ```
      <.dl>
        <:dt>Term</:dt>
        <:dd>Description</:dd>
      </.dl>
      ```

  """
  @spec dl(Socket.assigns()) :: Rendered.t()
  def dl(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:striped, fn -> @default_striped end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> assign_new(:dt, fn -> [] end)
      |> assign_new(:dd, fn -> [] end)
      |> build_rows()

    ~H"""
    <dl>
      <%= for {dt, dd} <- @rows do %>
        <div class="odd:bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
          <dt class="text-sm font-medium text-gray-500">
            <%= render_slot(dt) %>
          </dt>
          <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
            <%= render_slot(dd) %>
          </dd>
          </div>
      <% end %>
    </dl>
    """
  end

  defp build_rows(%{dt: dt, dd: dd} = assigns), do: assign(assigns, :rows, Enum.zip(dt, dd))
end
