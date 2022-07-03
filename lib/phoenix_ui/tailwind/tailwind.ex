defmodule PhoenixUI.Tailwind do
  @moduledoc """
  Defaults for each service
  """

  @colors [
    "amber",
    "blue",
    "cyan",
    "emerald",
    "fuchsia",
    "gray",
    "green",
    "indigo",
    "lime",
    "neutral",
    "orange",
    "pink",
    "purple",
    "red",
    "rose",
    "sky",
    "slate",
    "stone",
    "teal",
    "violet",
    "yellow",
    "zinc"
  ]

  @max_widths [
    "2xl",
    "3xl",
    "lg",
    "md",
    "screen-2xl",
    "screen-lg",
    "screen-md",
    "screen-sm",
    "screen-xl",
    "sm",
    "xl",
    "xs"
  ]

  @transition_durations [75, 100, 150, 200, 300, 500, 700, 1_000]

  @spec colors :: [String.t()]
  def colors, do: @colors

  @spec max_widths :: [String.t()]
  def max_widths, do: @max_widths

  @spec transition_durations :: [integer()]
  def transition_durations, do: @transition_durations
end
