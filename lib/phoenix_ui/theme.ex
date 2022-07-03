defmodule PhoenixUI.Theme do
  @moduledoc """
  Phoenix UI theme functionality.
  """
  alias PhoenixUI.Tailwind

  @additional_colors ["danger", "error", "primary", "secondary", "success", "warning", "info"]
  @default_attributes [
    %{
      name: "extend_class",
      type: "string",
      default: "",
      description: "Adds additional classes."
    },
    %{
      name: "phx-{any}",
      type: "binding",
      default: "",
      description: "Supports all Phoenix DOM element bindings."
    },
    %{
      name: "HTML attribute",
      type: "any",
      default: "",
      description: "Supports all HTML attributes."
    }
  ]

  @spec colors :: [String.t()]
  def colors, do: Tailwind.colors() ++ @additional_colors

  @spec default_attributes([map()]) :: [map()]
  def default_attributes(overrides \\ []) do
    @default_attributes
    |> Map.new(&{&1.name, &1})
    |> Map.merge(Map.new(overrides, &{&1.name, &1}))
    |> Map.values()
    |> Enum.sort_by(& &1.name)
  end

  @spec max_widths :: [integer()]
  def max_widths, do: Tailwind.max_widths()

  @spec transition_durations :: [integer()]
  def transition_durations, do: Tailwind.transition_durations()
end
