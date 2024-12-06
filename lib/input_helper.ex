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

  def example_input_for(year, day, part) do
    {:ok, input} =
      example_file_name(year, day, part)
      |> File.read()

    String.trim(input)
  end

  # def fetch_file(year, day) do
  #   # pull the session token from .env

  #   # make an HTTP request using the token to get the input for the specified day
  # end

  defp constructed_file_name(year, day) do
    day_val =
      day
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    "inputs/year_#{year}/day_#{day_val}.txt"
  end

  defp example_file_name(year, day, part) do
    day_val =
      day
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    part_val =
      part
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    "inputs/year_#{year}/day_#{day_val}_part_#{part_val}_example.txt"
  end
end
