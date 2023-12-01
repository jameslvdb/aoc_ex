defmodule InputHelper do
  @moduledoc """
  Collects inputs from the correct file.
  """

  def input_for(year, day) do
    {:ok, input} =
      constructed_file_name(year, day)
      |> File.read()

    String.trim(input)
  end

  defp constructed_file_name(year, day) do
    day_val =
      day
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    "../inputs/year_#{year}/day_#{day_val}.txt"
  end
end
