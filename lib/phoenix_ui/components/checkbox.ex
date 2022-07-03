defmodule PhoenixUI.Components.Checkbox do
  @moduledoc """
  Provides checkbox component.
  """
  import Phoenix.HTML.Form, only: [checkbox: 3, humanize: 1]
  import PhoenixUI.Components.{ErrorTag, FormGroup, HelperText, Label, TextInput}

  use PhoenixUI, :component

  @default_margin true
  @default_phx_debounce "blur"

  @doc """
  Renders checkbox component.

  ## Examples

      ```
      <.checkbox />
      ```

  """
  @spec checkbox(Socket.assigns()) :: Rendered.t()
  def checkbox(raw) do
    assigns =
      raw
      |> assign_new(:"phx-debounce", fn -> @default_phx_debounce end)
      |> assign_new(:margin, fn -> @default_margin end)
      |> build_checkbox_attrs()

    ~H"""
    <.form_group
      extend_class={assigns[:extend_class]}
      margin={@margin}
    >
      <%= case {assigns[:form], assigns[:field], assigns[:label]} do %>
        <% {nil, nil, label} when label in [false, nil] -> %>
          <.label margin={false}>
            <input type="checkbox" {@checkbox_attrs}/>
          </.label>
        <% {nil, nil, _label} -> %>
          <.label margin={false}>
            <input type="checkbox" {@checkbox_attrs}/>
            <%= @label %>
          </.label>
        <% {_form, _field, false} -> %>
          <.label field={@field} form={@form} margin={false}>
            <%= checkbox @form, @field, @checkbox_attrs %>
          </.label>
        <% {_form, _field, nil} -> %>
          <.label field={@field} form={@form} margin={false}>
            <%= checkbox @form, @field, @checkbox_attrs %>
            <%= humanize(@field) %>
          </.label>
        <% {_form, _field, _label} -> %>
          <.label field={@field} form={@form} margin={false}>
            <%= checkbox @form, @field, @checkbox_attrs %>
            <%= @label %>
          </.label>
      <% end %>
      <%= if assigns[:error] do %>
        <.error_tag field={@field} form={@form} />
      <% end %>
      <%= if assigns[:helper_text] && !assigns[:error] do %>
        <.helper_text>
          <%= @helper_text %>
        </.helper_text>
      <% end %>
    </.form_group>
    """
  end

  defp build_checkbox_attrs(assigns) do
    class = build_class(~w(checkbox mr-2 #{Map.get(assigns, :extend_class)}))

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class, :field, :form])
      |> Keyword.put_new(:class, class)

    assign(assigns, :checkbox_attrs, attrs)
  end
end
