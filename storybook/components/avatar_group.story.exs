defmodule Storybook.Components.AvatarGroup do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.AvatarGroup.avatar_group/1

  def imports, do: [{PhoenixUIWeb.CoreComponents, [icon: 1]}]

  def template do
    """
    <div class="flex flex-col items-center justify-center space-y-4" psb-code-hidden>
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
                variant: to_string(type)
              },
              slots:
                for idx <- 1..5 do
                  """
                  <:avatar src="/images/avatar#{idx}.jpg" />
                  """
                end
            }
          end
      },
      %Variation{
        attributes: %{max: 3},
        id: :max_avatars,
        slots:
          for idx <- 1..5 do
            """
            <:avatar src="/images/avatar#{idx}.jpg" />
            """
          end
      },
      %Variation{
        attributes: %{max: 10, total: 20},
        id: :total_avatars,
        slots:
          for idx <- 1..5 do
            """
            <:avatar src="/images/avatar#{idx}.jpg" />
            """
          end
      },
      %VariationGroup{
        id: :spacing,
        variations:
          for spacing <- ~w(xs sm md lg xl)a do
            %Variation{
              id: spacing,
              attributes: %{
                spacing: to_string(spacing)
              },
              slots:
                for idx <- 1..5 do
                  """
                  <:avatar src="/images/avatar#{idx}.jpg" />
                  """
                end
            }
          end
      },
      %VariationGroup{
        id: :size,
        variations:
          for size <- ~w(xs sm md lg xl)a do
            %Variation{
              id: size,
              attributes: %{
                size: to_string(size)
              },
              slots:
                for idx <- 1..5 do
                  """
                  <:avatar src="/images/avatar#{idx}.jpg" />
                  """
                end
            }
          end
      }
    ]
  end
end
