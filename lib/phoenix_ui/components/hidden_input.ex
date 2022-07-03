defmodule PhoenixUI.Components.HiddenInput do
  @moduledoc """
  Provides hidden input component.
  """
  import Phoenix.HTML.Form, only: [hidden_input: 3]

  use PhoenixUI, :component

  @doc """
  Renders hidden input component.

  ## Examples

      ```
      <.hidden_input />
      ```

  """
  @spec hidden_input(Socket.assigns()) :: Rendered.t()
  def hidden_input(raw) do
    assigns = assign(raw, :hidden_input_attrs, assigns_to_attributes(raw, [:field, :form]))

    ~H"""
    <%= if assigns[:form] && assigns[:field] do %>
      <%= hidden_input(@form, @field, @hidden_input_attrs) %>
    <% else %>
      <input type="hidden" {@hidden_input_attrs} />
    <% end %>
    """
  end
end
