defmodule Mix.Tasks.Tailwind.GenerateClasses do
  @moduledoc """
  Mix task for generating, parsing, and referencing all Phoenix UI classes.
  """
  use Mix.Task

  def run(_) do
    Application.put_env(:phoenix, :json_library, Jason)
    File.mkdir_p!("lib/phoenix_ui/tailwind")
    file = File.open!("lib/phoenix_ui/tailwind/generated_classes.ex", [:write])

    IO.binwrite(file, """
    defmodule PhoenixUI.Tailwind.GeneratedClasses do
      @moduledoc \"\"\"
      Referential PhoenixUI classes for JIT compilation:
    """)

    "lib/phoenix_ui/components/**/*.ex"
    |> Path.wildcard()
    |> Enum.map(&convert_path_to_module/1)
    |> Enum.filter(&generatable?/1)
    |> Enum.map(&apply(&1, :classes, []))
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.sort()
    |> Enum.each(fn class ->
      IO.binwrite(file, """
        - #{class}
      """)
    end)

    file
    |> IO.binwrite("""
      \"\"\"
    end
    """)
    |> File.close()

    # Mix.Task.run("format")
  end

  defp convert_path_to_module(path) do
    file = Path.basename(path, ".ex")
    Module.concat(["PhoenixUI", "Components", Macro.camelize(file)])
  end

  defp generatable?(module) do
    Code.ensure_loaded?(module) && function_exported?(module, :classes, 0)
  end
end
