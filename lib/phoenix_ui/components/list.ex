defmodule PhoenixUI.Components.List do
  @moduledoc """
  Provides list component.
  """
  use PhoenixUI, :component

  attr(:element, :string, default: "ul")

  @doc """
  Renders list component.

  ## Examples

      ```
      <.list>
        <.list_item>Item #1</.list_item>
        ...
      </.list>
      ```

  """
  @spec list(Socket.assigns()) :: Rendered.t()
  def list(prev_assigns) do
    assigns =
      prev_assigns
      |> assign_class(~w(py-1))
      |> assign_rest([:element])

    ~H"""
    <.dynamic_tag name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end

  attr(:element, :string, default: "li")

  @doc """
  Renders list item component.

  ## Examples

      ```
      <.list>
        <.list_item>Item #1</.list_item>
        ...
      </.list>
      ```

  """
  @spec list_item(Socket.assigns()) :: Rendered.t()
  def list_item(prev_assigns) do
    prev_assigns
    |> assign_class(~w(
        block w-full whitespace-nowrap py-2 px-4 text-sm font-normal
        text-slate-700 dark:text-slate-300 hover:bg-slate-100 dark:hover:bg-slate-100/25
      ))
    |> assign_rest([:element])
    |> list_item_markup()
  end

  defp list_item_markup(%{href: _} = assigns) do
    ~H"""
    <.link name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp list_item_markup(%{navigate: _} = assigns) do
    ~H"""
    <.link name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp list_item_markup(%{patch: _} = assigns) do
    ~H"""
    <.link {@rest}>
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  defp list_item_markup(assigns) do
    ~H"""
    <.dynamic_tag name={@element} {@rest}>
      <%= render_slot(@inner_block) %>
    </.dynamic_tag>
    """
  end
end
