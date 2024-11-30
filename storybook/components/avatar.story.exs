defmodule Storybook.Components.Avatar do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Avatar.avatar/1

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
          for type <- ~w(circular rounded square)a do
            %Variation{
              id: type,
              attributes: %{
                variant: to_string(type),
                src: "/images/avatar3.jpg"
              }
            }
          end
      },
      %VariationGroup{
        id: :image,
        variations:
          for idx <- 1..5 do
            %Variation{
              id: :"avatar#{idx}",
              attributes: %{
                src: "/images/avatar#{idx}.jpg"
              }
            }
          end
      },
      %VariationGroup{
        id: :letter,
        variations: [
          %Variation{
            id: :john_doe,
            attributes: %{
              alt: "John Doe"
            }
          },
          %Variation{
            id: :mary_smith,
            attributes: %{
              alt: "Mary Smith"
            }
          },
          %Variation{
            id: :alex_johnson,
            attributes: %{
              alt: "Alex Johnson"
            }
          }
        ]
      },
      %VariationGroup{
        id: :border,
        variations: [
          %Variation{
            id: :john_doe,
            attributes: %{
              border: true,
              src: "/images/avatar3.jpg"
            }
          },
          %Variation{
            id: :mary_smith,
            attributes: %{
              border: true,
              alt: "Mary Smith"
            }
          }
        ]
      },
      %VariationGroup{
        id: :icon,
        variations: [
          %Variation{
            id: :check,
            slots: [
              """
              <.icon name="hero-check-circle" />
              """
            ]
          },
          %Variation{
            id: :trash,
            slots: [
              """
              <.icon name="hero-trash" />
              """
            ]
          },
          %Variation{
            id: :pencil,
            slots: [
              """
              <.icon name="hero-pencil" />
              """
            ]
          },
          %Variation{
            id: :heart,
            slots: [
              """
              <.icon name="hero-heart" />
              """
            ]
          },
          %Variation{
            id: :information,
            slots: [
              """
              <.icon name="hero-information-circle" />
              """
            ]
          }
        ]
      },
      %VariationGroup{
        id: :size,
        variations:
          for size <- ~w(xs sm md lg xl)a do
            %Variation{
              id: size,
              attributes: %{size: to_string(size)}
            }
          end
      },
      %VariationGroup{
        id: :color,
        variations:
          for color <- ~w(red orange yellow green blue)a do
            %Variation{
              id: color,
              attributes: %{color: to_string(color)}
            }
          end
      },
      %Variation{
        id: :default
      }
    ]
  end
end
