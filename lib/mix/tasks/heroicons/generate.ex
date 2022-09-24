defmodule Mix.Tasks.Heroicons.Generate do
  @moduledoc """
  Mix task for generating heroicon component from downloaded heroicon repo svgs.
  """
  use Mix.Task

  @impl true
  def run(_args) do
    mini_icon_markup = load_markup("20/solid")
    outline_icon_markup = load_markup("24/outline")
    solid_icon_markup = load_markup("24/solid")

    file = File.open!("lib/phoenix_ui/components/heroicon.ex", [:write])

    IO.binwrite(file, """
    defmodule PhoenixUI.Components.Heroicon do
      @moduledoc \"\"\"
      Provides heroicon component.
      \"\"\"
      use PhoenixUI, :component

      attr(:color, :string, default: "inherit")
      attr(:name, :string, required: true)
      attr(:size, :string, default: "md")
      attr(:variant, :string, default: "solid")

      @doc \"\"\"
      Renders heroicon component.

      ## Examples

          ```
          <.heroicon name="academic-cap"/>
          ```

      \"\"\"
      @spec heroicon(Socket.assigns()) :: Rendered.t()
      def heroicon(assigns) do
        assigns
        |> assign_class(~w(
          heroicon inline-block
          #\{classes(:color, assigns)\}
          #\{classes(:size, assigns)\}
          #\{Map.get(assigns, :extend_class)\}
        ))
        |> assign_rest([:color, :extend_class, :name, :size, :variant])
        |> render_markup()
      end

      @doc \"\"\"
      Returns all component classes for Tailwind CSS JIT compilation.

      ## Examples

          iex> classes()
          ["class1", "class2", ...]

      \"\"\"
      @spec classes :: [String.t()]
      def classes do
        generate_all_classes(&heroicon/1,
          color: Theme.colors(),
          name: ["academic-cap"],
          size: ["xs", "sm", "md", "lg", "xl"] ++ range(0.25, 20, 0.25),
          variant: ["outline", "solid"]
        )
      end

      ### CSS Classes ##########################

      # Color
      defp classes(:color, %{color: "inherit"}), do: nil
      defp classes(:color, %{color: color}), do: "text-#\{color\}-500"

      # Size
      defp classes(:size, %{size: "xs"}), do: "h-3 w-3"
      defp classes(:size, %{size: "sm"}), do: "h-4 w-4"
      defp classes(:size, %{size: "md"}), do: "h-6 w-6"
      defp classes(:size, %{size: "lg"}), do: "h-8 w-8"
      defp classes(:size, %{size: "xl"}), do: "h-10 w-10"
      defp classes(:size, %{size: val}) when is_number(val), do: "w-[#\{val\}rem] h-[#\{val\}rem]"

      defp classes(_rule_group, _assigns), do: nil

      ### Markup ##########################

    """)

    "heroicons/optimized/**/*.svg"
    |> Path.absname(:code.priv_dir(:phoenix_ui))
    |> Path.wildcard()
    |> Enum.map(&Path.basename(&1, ".svg"))
    |> Enum.uniq()
    |> Enum.each(fn icon ->
      IO.binwrite(file, """
      # #{icon}
      defp render_markup(%{name: "#{icon}", variant: "mini"} = assigns) do
        ~H\"\"\"
        #{Map.get(mini_icon_markup, icon)}
        \"\"\"
      end

      defp render_markup(%{name: "#{icon}", variant: "outline"} = assigns) do
        ~H\"\"\"
        #{Map.get(outline_icon_markup, icon)}
        \"\"\"
      end

      defp render_markup(%{name: "#{icon}", variant: "solid"} = assigns) do
        ~H\"\"\"
        #{Map.get(solid_icon_markup, icon)}
        \"\"\"
      end
      """)
    end)

    IO.binwrite(file, """
    end
    """)

    File.close(file)

    Mix.Task.run("format")
  end

  defp load_markup(type) do
    "heroicons/optimized/#{type}/*.svg"
    |> Path.absname(:code.priv_dir(:phoenix_ui))
    |> Path.wildcard()
    |> Map.new(fn file ->
      {
        Path.basename(file, ".svg"),
        file
        |> File.read!()
        |> String.trim()
        |> String.replace("<svg", "<svg {@rest}")
      }
    end)
  end
end
