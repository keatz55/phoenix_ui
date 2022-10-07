defmodule Phoenix.UI.Components.Select do
  @moduledoc """
  Provides select component.
  """
  import Phoenix.HTML.Form, only: [select: 4]
  import Phoenix.UI.Components.{ErrorTag, FormGroup, HelperText, Heroicon, Label}

  use Phoenix.UI, :component

  @default_end_adornment "chevron-down"
  @default_full_width false
  @default_margin true
  @default_phx_debounce "blur"
  @default_variant "simple"

  @doc """
  Renders select component.

  ## Examples

      ```
      <.select />
      ```

  """
  @spec select(Socket.assigns()) :: Rendered.t()
  def select(raw) do
    assigns =
      raw
      |> assign_new(:"phx-debounce", fn -> @default_phx_debounce end)
      |> assign_new(:end_adornment, fn -> @default_end_adornment end)
      |> assign_new(:full_width, fn -> @default_full_width end)
      |> assign_new(:margin, fn -> @default_margin end)
      |> assign_new(:options, fn -> [] end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> assign(:invalid?, has_error?(raw))
      |> build_select_attrs()

    ~H"""
    <.form_group extend_class={assigns[:extend_class]} margin={@margin}>
      <%= if assigns[:label] == nil do %>
        <.label field={@field} form={@form} />
      <% end %>
      <%= if assigns[:label] do %>
        <.label field={@field} form={@form}>
          <%= @label %>
        </.label>
      <% end %>
      <div class="relative">
        <%= if assigns[:start_adornment] do %>
          <div class="pl-3 absolute left-0 top-1/2 -translate-y-1/2 text-slate-500">
            <%= if is_bitstring(@start_adornment) do %>
              <.heroicon color="inherit" name={@start_adornment} variant="outline" />
            <% else %>
              <%= render_slot(@start_adornment) %>
            <% end %>
          </div>
        <% end %>
        <%= select(@form, @field, @options, @select_attrs) %>
        <%= if assigns[:end_adornment] do %>
          <div class="px-3 absolute right-0 top-1/2 -translate-y-1/2 text-slate-500">
            <%= if is_bitstring(@end_adornment) do %>
              <.heroicon color="inherit" name={@end_adornment} variant="outline" />
            <% else %>
              <%= render_slot(@end_adornment) %>
            <% end %>
          </div>
        <% end %>
      </div>
      <%= if assigns[:invalid?] do %>
        <.error_tag field={@field} form={@form} />
      <% end %>
      <%= if assigns[:helper_text] && !assigns[:invalid?] do %>
        <.helper_text>
          <%= @helper_text %>
        </.helper_text>
      <% end %>
    </.form_group>
    """
  end

  defp build_select_attrs(assigns) do
    class = build_class(~w(
      appearance-none block py-2 pr-2 text-slate-700 dark:text-slate-300 text-base outline-none focus:outline-none
      placeholder-slate-400 dark:placeholder-slate-600 transition-all ease-in-out duration-200
      #{classes(:background, assigns)}
      #{classes(:end_adornment, assigns)}
      #{classes(:rounded, assigns)}
      #{classes(:start_adornment, assigns)}
      #{classes(:variant, assigns)}
      #{classes(:width, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([
        :end_adornment,
        :extend_class,
        :field,
        :form,
        :full_width,
        :invalid?,
        :margin,
        :options,
        :start_adornment,
        :variant
      ])
      |> Keyword.put_new(:class, class)

    assign(assigns, :select_attrs, attrs)
  end

  ### CSS Classes ##########################

  # Background
  defp classes(:background, %{variant: "solid"}) do
    "bg-slate-100 dark:bg-slate-800 focus:bg-transparent dark:focus:bg-transparent"
  end

  defp classes(:background, %{variant: "underline"}), do: "bg-transparent"
  defp classes(:background, _assigns), do: "bg-white dark:bg-slate-900"

  # End Adornment
  defp classes(:end_adornment, %{end_adornment: _}), do: "pr-12"
  defp classes(:end_adornment, _assigns), do: "pr-3"

  # Rounded
  defp classes(:rounded, %{variant: "underline"}), do: nil
  defp classes(:rounded, %{variant: "unstyled"}), do: nil
  defp classes(:rounded, _assigns), do: "rounded-md"

  # Start Adornment
  defp classes(:start_adornment, %{start_adornment: _}), do: "pl-12"
  defp classes(:start_adornment, _assigns), do: "pl-3"

  # Variant - Simple
  defp classes(:variant, %{variant: "simple"}) do
    "border border-slate-300 shadow-sm focus:border-blue-300 focus:ring focus:ring-opacity-50 focus:ring-blue-200"
  end

  # Variant - Solid
  defp classes(:variant, %{variant: "solid"}) do
    "shadow-sm border border-transparent focus:border-slate-500"
  end

  # Variant - Underline
  defp classes(:variant, %{variant: "underline"}) do
    "border-b-2 border-slate-300 shadow-sm focus:border-slate-600"
  end

  # Variant - Unstyled
  defp classes(:variant, %{variant: "unstyled"}) do
    "border border-slate-300 shadow-sm ring-0 focus:ring-1 focus:ring-blue-500 focus:border-blue-500"
  end

  # Width
  defp classes(:width, %{full_width: true}), do: "w-full"

  defp classes(_rule_group, _assigns), do: nil
end
