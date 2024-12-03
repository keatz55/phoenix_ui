defmodule Storybook.Components.Button do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Button.button/1

  def imports, do: [{PhoenixUIWeb.CoreComponents, [icon: 1]}]

  def template do
    """
    <div class="flex flex-wrap justify-center items-center space-x-4" psb-code-hidden>
      <.psb-variation-group/>
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :variant,
        variations:
          for variant <- ~w(plain solid outline)a do
            %Variation{
              attributes: %{variant: to_string(variant)},
              id: variant,
              slots: ["Button"]
            }
          end
      },
      %VariationGroup{
        id: :color,
        variations:
          for {variant, color} <- [{:plain, :pink}, {:solid, :green}, {:outline, :red}] do
            %Variation{
              attributes: %{color: to_string(color), variant: to_string(variant)},
              id: color,
              slots: ["Button"]
            }
          end
      },
      %VariationGroup{
        id: :sizes,
        variations:
          for size <- ~w(sm md lg)a do
            %Variation{
              attributes: %{size: to_string(size)},
              id: size,
              slots: ["Button"]
            }
          end
      },
      %VariationGroup{
        id: :icons,
        variations: [
          %Variation{
            attributes: %{variant: "outline"},
            id: :outline,
            slots: [
              """
              <.icon class="icon" name="hero-shopping-cart" />
              <span>Outline</span>
              """
            ]
          },
          %Variation{
            attributes: %{variant: "solid"},
            id: :solid,
            slots: [
              """
              <span>Solid</span>
              <.icon class="icon" name="hero-cake" />
              """
            ]
          }
        ]
      },
      %VariationGroup{
        id: :disabled,
        variations:
          for variant <- ~w(plain solid outline)a do
            %Variation{
              attributes: %{disabled: true, variant: to_string(variant)},
              id: variant,
              slots: ["Button"]
            }
          end
      }
    ]
  end
end
