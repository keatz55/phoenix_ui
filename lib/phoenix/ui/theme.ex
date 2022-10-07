defmodule Phoenix.UI.Theme do
  @moduledoc """
  Phoenix UI theme functionality.
  """
  alias Phoenix.UI.Tailwind

  @additional_colors ["danger", "error", "primary", "secondary", "success", "warning", "info"]

  @doc """
  Returns a list of supported Phoenix.UI colors.

  ## Examples

      iex> colors()
      ["amber", "blue", ...]

  """
  @spec colors :: [String.t()]
  def colors, do: Tailwind.colors() ++ @additional_colors

  @doc """
  Returns a list of supported Phoenix.UI widths.

  ## Examples

      iex> max_widths()
      ["2xl", "3xl", ...]

  """
  @spec max_widths :: [String.t()]
  def max_widths, do: Tailwind.max_widths()

  @doc """
  Returns a list of supported Phoenix.UI transition durations.

  ## Examples

      iex> transition_durations()
      [75, 100, ...]

  """
  @spec transition_durations :: [integer()]
  def transition_durations, do: Tailwind.transition_durations()
end
