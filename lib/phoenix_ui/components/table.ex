defmodule PhoenixUI.Components.Table do
  @moduledoc """
  Provides a table components.
  """
  import PhoenixUI.Components.Paper

  use PhoenixUI, :component

  @doc """
  Renders table component.

  ## Examples

      ```
      <.table>
        <.tr>
          <.th>Month</.th>
          <.th>Savings</.th>
        </.tr>
        <.tr>
          <.td>January</.td>
          <.td>$100</.td>
        </.tr>
      </.table>
      ```

  """
  @spec table(Socket.assigns()) :: Rendered.t()
  def table(assigns) do
    assigns
    |> build_paper_assigns()
    |> generate_markup()
  end

  @doc """
  Renders body in table.

  ## Examples

      ```
      <.table>
        <.tbody>
          <.tr>
            <.td>Cell A</.td>
            <.td>Cell B</.td>
          </.tr>
        </.tbody>
      </.table>
      ```

  """
  @spec tbody(Socket.assigns()) :: Rendered.t()
  def tbody(assigns) do
    ~H"""
    <tbody>
      <%= render_slot(@inner_block) %>
    </tbody>
    """
  end

  @doc """
  Renders standard data cell in table.

  ## Examples

      ```
      <.table>
        <.tr>
          <.td>Cell A</.td>
          <.td>Cell B</.td>
        </.tr>
      </.table>
      ```

  """
  @spec td(Socket.assigns()) :: Rendered.t()
  def td(assigns) do
    ~H"""
    <td class="p-3 break-words">
      <%= render_slot(@inner_block) %>
    </td>
    """
  end

  @doc """
  Renders footer in table.

  ## Examples

      ```
      <.table>
        <.tfoot>
          <.tr>
            <.th>Sum</.th>
            <.th>$180</.th>
          </.tr>
        </.tfoot>
      </.table>
      ```

  """
  @spec tfoot(Socket.assigns()) :: Rendered.t()
  def tfoot(assigns) do
    ~H"""
    <tfoot>
      <%= render_slot(@inner_block) %>
    </tfoot>
    """
  end

  @doc """
  Renders header cell in table.

  ## Examples

      ```
      <.table>
        <.thead>
          <.tr>
            <.th>Month</.th>
            <.th>Savings</.th>
          </.tr>
        </.thead>
      </.table>
      ```

  """
  @spec th(Socket.assigns()) :: Rendered.t()
  def th(raw_assigns) do
    attrs = Map.drop(raw_assigns, [:__changed__, :inner_block])
    assigns = Map.put(raw_assigns, :attrs, attrs)

    ~H"""
    <th
      class="p-3 text-left text-xs font-medium text-slate-500 dark:text-white uppercase tracking-wider"
      {@attrs}
    >
      <%= render_slot(@inner_block) %>
    </th>
    """
  end

  @doc """
  Renders header in table.

  ## Examples

      ```
      <.table>
        <.thead>
          ...
        </.thead>
      </.table>
      ```

  """
  @spec thead(Socket.assigns()) :: Rendered.t()
  def thead(assigns) do
    ~H"""
    <thead class="border-b border-slate-200 dark:border-slate-600 text-sm font-medium bg-slate-50 dark:bg-slate-700">
      <%= render_slot(@inner_block) %>
    </thead>
    """
  end

  @doc """
  Renders row in table.

  ## Examples

      ```
      <.table>
        <.tr>
          ...
        </.tr>
      </.table>
      ```

  """
  @spec tr(Socket.assigns()) :: Rendered.t()
  def tr(assigns) do
    ~H"""
    <tr class="even:bg-slate-50 even:dark:bg-slate-700">
      <%= render_slot(@inner_block) %>
    </tr>
    """
  end

  #############################################################################################
  ### Markup
  #############################################################################################

  defp generate_markup(assigns) do
    ~H"""
    <.paper {@paper} extend_class="overflow-x-auto" variant="elevated">
      <table class="w-full text-left text-slate-700 dark:text-slate-300">
        <%= render_slot(@inner_block) %>
      </table>
    </.paper>
    """
  end

  #############################################################################################
  ### Paper Assigns
  #############################################################################################

  defp build_paper_assigns(assigns) do
    paper =
      Map.drop(assigns, [
        :__changed__,
        :inner_block
      ])

    assign(assigns, :paper, paper)
  end
end
