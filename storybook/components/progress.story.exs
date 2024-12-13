defmodule Storybook.Components.Progress do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Progress.progress/1

  def template do
    """
    <div class="flex w-full justify-center mb-2 last:mb-0" psb-code-hidden>
      <.psb-variation/>
    </div>
    """
  end

  def variations do
    [
      %VariationGroup{
        id: :variant,
        variations:
          for variant <- ~w(linear radial)a do
            %Variation{
              attributes: %{text: "75%", value: 75, variant: to_string(variant)},
              id: variant
            }
          end
      },
      %VariationGroup{
        id: :animate,
        variations:
          for variant <- ~w(radial)a do
            %Variation{
              attributes: %{
                class: "animate-spin",
                variant: to_string(variant)
              },
              id: variant
            }
          end
      },
      %VariationGroup{
        id: :color,
        variations:
          List.flatten(
            for variant <- ~w(linear radial)a do
              for color <- ~w(green blue red)a do
                %Variation{
                  attributes: %{
                    color: to_string(color),
                    text: "50%",
                    value: 50,
                    variant: to_string(variant)
                  },
                  id: :"#{variant}_#{color}"
                }
              end
            end
          )
      },
      %VariationGroup{
        id: :size,
        variations:
          List.flatten(
            for variant <- ~w(linear radial)a do
              for size <- ~w(sm md lg)a do
                %Variation{
                  attributes: %{
                    size: to_string(size),
                    text: "75%",
                    value: 75,
                    variant: to_string(variant)
                  },
                  id: :"#{variant}_#{size}"
                }
              end
            end
          )
      },
      %VariationGroup{
        id: :square,
        variations:
          for variant <- ~w(linear radial)a do
            %Variation{
              attributes: %{square: true, text: "50%", value: 50, variant: to_string(variant)},
              id: variant
            }
          end
      }
    ]
  end
end
