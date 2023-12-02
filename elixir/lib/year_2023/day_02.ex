defmodule Year2023.Day02 do
  # def full_part_1() do
  #   InputHelper.input_for(2023, 2)
  #   |> String.split("\n")
  #   |> part_1()
  # end
  @max_red_cubes 12
  @max_green_cubes 13
  @max_blue_cubes 14

  def process_game(line) do
    game_id = game_id(line)

    trim_game_id(line)
    |> split_draws()
    |> Enum.flat_map(&split_colors(&1))
    |> Enum.map(&validate_draw(&1))
    |> Enum.all?()
  end

  def validate_draw(draw) do
    [number, color] = String.split(draw)
    validate_draw(String.to_integer(number), color)
  end

  def validate_draw(number, color) when color == "blue" do
    number <= @max_blue_cubes
  end

  def validate_draw(number, color) when color == "green" do
    number <= @max_green_cubes
  end

  def validate_draw(number, color) when color == "red" do
    number <= @max_red_cubes
  end

  def game_id(str) do
    Regex.run(~r/Game (\d{1,}):/, str)
    |> List.last()
    |> String.to_integer()
  end

  def trim_game_id(str) do
    String.split(str, ~r/Game \d{1,}: /, trim: true)
    |> List.first()
  end

  def split_draws(str) do
    String.split(str, "; ")
  end

  def split_colors(str) do
    String.split(str, ", ")
  end
end
