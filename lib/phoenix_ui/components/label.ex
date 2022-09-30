defmodule Phoenix.UI.Components.Label do
  @moduledoc """
  Provides label component.
  """
  import Phoenix.HTML.Form

  use Phoenix.UI, :component

  @default_disabled false
  @default_margin true

  @doc """
  Renders label component.

  ## Examples

      ```
      <.label
        field={:name}
        form={f}
      >
        Name
      </.label>
      ```

  """
  @spec label(Socket.assigns()) :: Rendered.t()
  def label(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:disabled, fn -> @default_disabled end)
      |> assign_new(:margin, fn -> @default_margin end)
      |> build_label_attrs()

    ~H"""
    <%= case {assigns[:form], assigns[:field], assigns[:inner_block]} do %>
      <% {nil, nil, _inner_block} -> %>
        <label {@label_attrs}>
          <%= render_slot(@inner_block) %>
        </label>
      <% {_form, _field, nil} -> %>
        <%= label(@form, @field, @label_attrs) %>
      <% {_form, _field, _inner_block} -> %>
        <%= label(@form, @field, @label_attrs) do %>
          <%= render_slot(@inner_block) %>
        <% end %>
    <% end %>
    """
  end

  ### Label Attrs ##########################

  defp build_label_attrs(assigns) do
    class = build_class(~w(
      label flex items-center
      #{classes(:color, assigns)}
      #{classes(:margin, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([:extend_class, :field, :form, :invalid?, :margin])
      |> Keyword.put_new(:class, class)

    assign(assigns, :label_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Color
  defp classes(:color, %{invalid?: true}), do: "text-red-500"

  defp classes(:color, _assigns) do
    "text-slate-600 dark:text-slate-300 disabled:text-slate-500 dark:disabled:text-slate-400 invalid:text-red-500"
  end

  # Margin
  defp classes(:margin, %{margin: true}), do: "mb-2"

  defp classes(_rule_group, _assigns), do: nil
end
