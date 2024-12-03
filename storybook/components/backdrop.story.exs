defmodule Storybook.Components.Backdrop do
  use PhoenixStorybook.Story, :component

  def function, do: &PhoenixUIWeb.Components.Backdrop.backdrop/1

  def imports do
    [
      {PhoenixUIWeb.Components.Backdrop, [hide_backdrop: 1, show_backdrop: 1]},
      {PhoenixUIWeb.Components.Button, [button: 1]}
    ]
  end

  def template do
    """
    <.button
      phx-click-away={hide_backdrop(":variation_id")}
      phx-click={show_backdrop(":variation_id")}
      phx-key="escape"
      phx-window-keydown={hide_backdrop(":variation_id")}
      psb-code-hidden
    >
      Show backdrop
    </.button>
    <.psb-variation/>
    """
  end

  def variations do
    [
      %Variation{
        id: :basic
      },
      %Variation{
        attributes: %{
          class:
            "flex items-center justify-center border-8 border-zinc-700 dark:border-zinc-300 text-7xl text-zinc-700 dark:text-zinc-300",
          invisible: true
        },
        id: :invisible,
        slots: [
          """
          Invisible
          """
        ]
      }
    ]
  end
end
