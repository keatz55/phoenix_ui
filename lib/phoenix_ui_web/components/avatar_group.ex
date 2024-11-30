defmodule PhoenixUIWeb.Components.AvatarGroup do
  @moduledoc """
  Provides avatar group component.
  """
  use Phoenix.Component

  import PhoenixUIWeb.Components.Avatar, only: [avatar: 1]

  alias Phoenix.LiveView.Rendered
  alias Phoenix.LiveView.Socket

  @doc """
  Renders its avatar children as a stack. Use the max prop to limit the number of avatars.

  ## Examples

      ```
      <.avatar_group>
        <:avatar src={@src1}/>
        <:avatar src={@src2}/>
        <:avatar src={@src3}/>
        ...
      </.avatar_group>
      ```

  """

  attr :border, :boolean, default: true
  attr :color, :string, default: "zinc"
  attr :element, :string, default: "div"
  attr :max, :integer, default: 5
  attr :rest, :global
  attr :size, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"]
  attr :spacing, :string, default: "md", values: ["xs", "sm", "md", "lg", "xl"]
  attr :total, :integer
  attr :variant, :string, default: "circular", values: ["circular", "rounded", "square"]

  slot :avatar, required: true, validate_attrs: false

  @spec avatar_group(Socket.assigns()) :: Rendered.t()
  def avatar_group(assigns) do
    assigns = assign(assigns, :extra, calc_extra(assigns))

    ~H"""
    <.dynamic_tag
      class={
        assigns[:class] ||
          [
            "avatar-group inline-flex flex-row-reverse items-center",
            spacing_styles(@spacing),
            assigns[:extend_class]
          ]
      }
      tag_name={@element}
      {@rest}
    >
      <.avatar :if={@extra > 0} border={@border} color={@color} size={@size} variant={@variant}>
        +<%= @extra %>
      </.avatar>
      <.avatar
        :for={avatar <- Enum.take(@avatar, @max)}
        border={avatar[:border] || @border}
        color={avatar[:color] || @color}
        size={avatar[:size] || @size}
        variant={avatar[:variant] || @variant}
        {assigns_to_attributes(avatar, [:border, :color, :size, :variant])}
      />
    </.dynamic_tag>
    """
  end

  defp calc_extra(%{avatar: avtrs, max: max, total: total}), do: total - min(max, length(avtrs))
  defp calc_extra(%{avatar: avatars, max: max}), do: length(avatars) - max

  defp spacing_styles("xs"), do: "pl-2.5 [&_.avatar]:-ml-2.5"
  defp spacing_styles("sm"), do: "pl-2 [&_.avatar]:-ml-2"
  defp spacing_styles("md"), do: "pl-1.5 [&_.avatar]:-ml-1.5"
  defp spacing_styles("lg"), do: "pl-1 [&_.avatar]:-ml-1"
  defp spacing_styles("xl"), do: "pl-0.5 [&_.avatar]:-ml-0.5"
end
