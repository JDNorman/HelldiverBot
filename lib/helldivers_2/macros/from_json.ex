defmodule Helldivers2.Macros.FromJson do
  @moduledoc """
  Macro that generates mappings from JSON files.

  This method generates a `parse/1` method that returns the value.
  This allows constant time lookups from the JSON.
  """

  defmacro __using__(_filename) do
    mappings = %{}
    # mappings = :helldivers_2
    # |> :code.priv_dir()
    # |> Path.join(filename)
    # |> File.read!()
    # |> Jason.decode!()

    for {key, value} <- mappings do
      quote do
        defp lookup("#{unquote(key)}"), do: unquote(value)
      end
    end ++ []
  end
end