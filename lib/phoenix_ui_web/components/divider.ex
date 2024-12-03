defmodule PhoenixUIWeb.Components.Divider do
  @moduledoc """
  Provides divider-related components.
  """
  use Phoenix.Component

  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  @doc """
  Provides a thin, unobtrusive line for grouping elements to reinforce visual hierarchy.

  ## Examples

  ```heex
  <.divider/>
  ```
  """

  attr :class, :any, doc: "Extend existing styles applied to the component."
  attr :rest, :global
  attr :soft, :boolean, default: false

  @spec divider(Socket.assigns()) :: Rendered.t()
  def divider(assigns) do
    ~H"""
    <hr
      class={[
        "divider w-full border-t",
        styles(:soft, assigns),
        assigns[:class]
      ]}
      role="presentation"
      {@rest}
    />
    """
  end

  ### Styles ##########################

  defp styles(:soft, %{soft: true}), do: "border-zinc-950/5 dark:border-white/5"
  defp styles(:soft, %{soft: false}), do: "border-zinc-950/10 dark:border-white/10"

  defp styles(_, _), do: nil
end
