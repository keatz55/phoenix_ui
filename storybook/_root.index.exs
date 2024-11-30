defmodule Storybook.Root do
  @moduledoc """
  Storybook root index file
  """
  use PhoenixStorybook.Index

  @impl true
  def folder_icon, do: {:fa, "book-open", :light, "psb-mr-1"}
  def folder_name, do: "Phoenix UI"

  @impl true
  def entry("welcome") do
    [
      name: "Getting started",
      icon: {:fa, "hand-wave", :thin}
    ]
  end
end
