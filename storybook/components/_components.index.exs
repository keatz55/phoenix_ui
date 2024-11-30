defmodule Storybook.Components do
  @moduledoc """
  Components dir index file
  """
  use PhoenixStorybook.Index

  @impl true
  def folder_icon, do: {:fa, "toolbox", :thin}
  def folder_open?, do: true

  @impl true
  def entry("badge"), do: [icon: {:fa, "badge-check", :thin}]
end
