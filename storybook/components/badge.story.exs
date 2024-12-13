defmodule Storybook.Components.Badge do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Badge.badge/1

  def imports,
    do: [{PhoenixUIWeb.Components.Button, [button: 1]}, {PhoenixUIWeb.CoreComponents, [icon: 1]}]

  def template do
    """
    <div class="text-zinc-700 dark:text-zinc-200 flex w-full justify-center mb-2.5 last:mb-0" psb-code-hidden>
      <.psb-variation/>
    </div>
    """
  end

  def variations do
    [
      %Variation{
        id: :basic,
        slots: [
          """
          <.icon name="hero-envelope"/>
          <:badge>99+</:badge>
          """
        ]
      },
      %VariationGroup{
        id: :position,
        variations:
          for position <- ~w(top_left top top_right right bottom_right bottom bottom_left left)a do
            %Variation{
              attributes: %{position: to_string(position)},
              id: position,
              slots: [
                """
                <.button variant="outline">
                  <.icon class="icon" name="hero-envelope"/>
                </.button>
                <:badge>99+</:badge>
                """
              ]
            }
          end
      },
      %VariationGroup{
        id: :color,
        variations:
          for color <- ~w(red blue green)a do
            %Variation{
              attributes: %{color: to_string(color)},
              id: color,
              slots: [
                """
                <.icon class="icon" name="hero-envelope"/>
                <:badge>99+</:badge>
                """
              ]
            }
          end
      },
      %VariationGroup{
        id: :empty_or_invisible,
        variations: [
          %Variation{
            id: :empty,
            slots: [
              """
              <.icon name="hero-envelope"/>
              <:badge></:badge>
              """
            ]
          },
          %Variation{
            attributes: %{invisible: true},
            id: :invisible,
            slots: [
              """
              <.icon name="hero-envelope"/>
              <:badge></:badge>
              """
            ]
          }
        ]
      },
      %Variation{
        attributes: %{border: true},
        id: :border,
        slots: [
          """
          <.icon name="hero-envelope"/>
          <:badge>99+</:badge>
          """
        ]
      }
    ]
  end
end
