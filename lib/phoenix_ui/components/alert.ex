defmodule PhoenixUI.Components.Alert do
  @moduledoc """
  Provides Alert component
  """
  import PhoenixUI.Components.Heroicon

  use PhoenixUI, :component

  @default_action_icon_name "x"
  @default_icon_color "inherity"
  @default_icon_variant "outline"
  @default_severity "info"
  @default_variant "standard"

  @doc """
  Renders alert component.

  ## Examples

      ```
      <.alert>
        ruh roh!
      </.alert>
      ```

  """
  @spec alert(Socket.assigns()) :: Rendered.t()
  def alert(raw_assigns) do
    assigns =
      raw_assigns
      |> assign_new(:icon, fn -> [] end)
      |> assign_new(:severity, fn -> @default_severity end)
      |> assign_new(:variant, fn -> @default_variant end)
      |> build_action_attrs()
      |> build_action_wrapper_attrs()
      |> build_container_attrs()
      |> build_icon_attrs()
      |> build_icon_wrapper_attrs()

    ~H"""
    <div {@container_attrs}>
      <%= if assigns[:icon] do %>
        <div {@icon_wrapper_attrs}>
          <%= if is_slot?(@icon) do %>
            <%= render_slot(@icon) %>
          <% else %>
            <.heroicon {@icon_attrs} />
          <% end %>
        </div>
      <% end %>
      <%= if assigns[:title] do %>
        <div class="font-bold mb-1">
          <%= if is_bitstring(@title) do %>
            <%= @title %>
          <% else %>
            <%= render_slot(@title) %>
          <% end %>
        </div>
      <% end %>
      <div>
        <%= if assigns[:content] do %>
          <%= render_slot(@content) %>
        <% else %>
          <%= render_slot(@inner_block) %>
        <% end %>
      </div>
      <%= if assigns[:action] do %>
        <div {@action_wrapper_attrs}>
          <%= if is_slot?(@action) do %>
            <%= render_slot(@action) %>
          <% else %>
            <.heroicon {@action_attrs} />
          <% end %>
        </div>
      <% end %>
    </div>
    """
  end

  @doc """
  Returns all possible component classes for Tailwind CSS JIT compilation.

  ## Examples

      iex> classes()
      ["class1", "class2", ...]

  """
  @spec classes :: [String.t()]
  def classes do
    generate_all_classes(&alert/1,
      action: [["phx-click": "lv:clear-flash"]],
      severity: ["error", "info", "success", "warning"],
      variant: ["filled", "outlined", "standard"]
    )
  end

  ### Container Attrs ##########################

  defp build_container_attrs(assigns) do
    class = build_class(~w(
      alert relative py-4 rounded-lg
      #{classes(:container, :color, assigns)}
      #{classes(:container, :spacing, assigns)}
      #{Map.get(assigns, :extend_class)}
    ))

    attrs =
      assigns
      |> assigns_to_attributes([
        :action_attrs,
        :action_wrapper_attrs,
        :action,
        :color,
        :content,
        :extend_class,
        :icon_attrs,
        :icon_wrapper_attrs,
        :icon,
        :title,
        :variant
      ])
      |> Keyword.put_new(:class, class)
      |> Keyword.put_new(:role, "alert")

    assign(assigns, :container_attrs, attrs)
  end

  ### Icon Attrs ##########################

  defp build_icon_attrs(%{icon: false} = assigns), do: assigns

  defp build_icon_attrs(%{icon: icon, severity: severity} = assigns) do
    extend_class = build_class(~w(
      alert-icon
      #{Keyword.get(icon, :extend_class)}
    ))

    attrs =
      icon
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put(:extend_class, extend_class)
      |> Keyword.put_new(:color, @default_icon_color)
      |> Keyword.put_new(:name, icon_mapping(severity))
      |> Keyword.put_new(:variant, @default_icon_variant)

    assign(assigns, :icon_attrs, attrs)
  end

  defp build_icon_attrs(assigns), do: assigns

  ### Icon Wrapper Attrs ##########################

  defp build_icon_wrapper_attrs(%{icon: false} = assigns), do: assigns

  defp build_icon_wrapper_attrs(%{icon: _icon} = assigns) do
    class = build_class(~w(
      alert-icon-wrapper absolute left-4
      #{classes(:icon_wrapper, :color, assigns)}
      #{classes(:icon_wrapper, :position, assigns)}
    ))

    assign(assigns, :icon_wrapper_attrs, %{class: class})
  end

  defp build_icon_wrapper_attrs(assigns), do: assigns

  ### Action Attrs ##########################

  defp build_action_attrs(%{action: action} = assigns) do
    extend_class = build_class(~w(
      alert-action cursor-pointer
      #{Keyword.get(action, :extend_class)}
    ))

    attrs =
      action
      |> assigns_to_attributes([:extend_class])
      |> Keyword.put(:extend_class, extend_class)
      |> Keyword.put_new(:name, @default_action_icon_name)
      |> Keyword.put_new(:variant, @default_icon_variant)

    assign(assigns, :action_attrs, attrs)
  end

  defp build_action_attrs(assigns), do: assigns

  ### Action Wrapper Attrs ##########################

  defp build_action_wrapper_attrs(%{action: _action} = assigns) do
    class = build_class(~w(
      alert-action-wrapper absolute right-4 transition-all ease-in-out duration-300
      #{classes(:action_wrapper, :color, assigns)}
      #{classes(:action_wrapper, :position, assigns)}
    ))

    assign(assigns, :action_wrapper_attrs, %{class: class})
  end

  defp build_action_wrapper_attrs(assigns), do: assigns

  ### CSS Classes ##########################

  # Container - Color
  defp classes(:container, :color, %{variant: "filled", severity: color}) do
    "bg-#{color}-600 dark:bg-#{color}-700 text-white"
  end

  defp classes(:container, :color, %{variant: "outlined", severity: color}) do
    "border border-#{color}-500 text-#{color}-800 dark:text-#{color}-200"
  end

  defp classes(:container, :color, %{variant: "standard", severity: color}) do
    "bg-#{color}-500/[.15] text-#{color}-800 dark:text-#{color}-200"
  end

  # Container - Spacing
  defp classes(:container, :spacing, %{icon: false, action: _}), do: "pl-4 pr-14"
  defp classes(:container, :spacing, %{icon: _, action: _}), do: "px-14"
  defp classes(:container, :spacing, %{icon: false}), do: "px-4"
  defp classes(:container, :spacing, %{icon: _}), do: "pl-14 pr-4"
  defp classes(:container, :spacing, %{action: _}), do: "pl-4 pr-14"
  defp classes(:container, :spacing, _assigns), do: "px-4"

  # Icon Wrapper - Color
  defp classes(:icon_wrapper, :color, %{variant: "outlined", severity: color}) do
    "text-#{color}-500"
  end

  defp classes(:icon_wrapper, :color, %{variant: "standard", severity: color}) do
    "text-#{color}-600"
  end

  # Icon Wrapper - Position
  defp classes(:icon_wrapper, :position, %{title: _}), do: "top-4"
  defp classes(:icon_wrapper, :position, _assigns), do: "top-1/2 -translate-y-1/2"

  # Action Wrapper - Color
  defp classes(:action_wrapper, :color, %{variant: "filled"}) do
    "text-white hover:text-white/75"
  end

  defp classes(:action_wrapper, :color, %{variant: "outlined", severity: color}) do
    "hover:text-#{color}-600/75"
  end

  defp classes(:action_wrapper, :color, %{variant: "standard", severity: color}) do
    "hover:text-#{color}-900/50 dark:hover:text-#{color}-200/50"
  end

  # Action Wrapper - Position
  defp classes(:action_wrapper, :position, %{title: _}), do: "top-4"
  defp classes(:action_wrapper, :position, _assigns), do: "top-1/2 -translate-y-1/2"

  defp classes(_element, _rule_group, _assigns), do: nil

  defp icon_mapping("error"), do: "exclamation-circle"
  defp icon_mapping("danger"), do: "exclamation-circle"
  defp icon_mapping("info"), do: "information-circle"
  defp icon_mapping("success"), do: "check-circle"
  defp icon_mapping("warning"), do: "exclamation"
end
