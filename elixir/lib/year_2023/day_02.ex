defmodule Year2023.Day02 do
  @max_red_cubes 12
  @max_green_cubes 13
  @max_blue_cubes 14

  def full_part_1() do
    InputHelper.input_for(2023, 2)
    |> String.split("\n")
    |> part_1()
  end

  def part_1(lines) do
    Enum.reduce(lines, 0, fn line, acc ->
      acc + process_game(line)
    end)
  end

  def full_part_2() do
    InputHelper.input_for(2023, 2)
    |> String.split("\n")
    |> part_2()
  end

  def part_2(lines) do
    Enum.map(lines, &trim_game_id/1)
    |> Enum.map(&split_draws/1)
    |> Enum.map(&process_products/1)
    |> Enum.map(&group_draws_by_color/1)
    |> Enum.map(&lowest_possible_cubes/1)
    |> Enum.map(&cube_product/1)
    |> Enum.sum()
  end

  def process_products(draws) do
    Enum.flat_map(draws, &split_colors/1)
  end

  def process_game(line) do
    game_id = game_id(line)

    valid_game? =
      trim_game_id(line)
      |> split_draws()
      |> Enum.flat_map(&split_colors(&1))
      |> Enum.map(&validate_draw(&1))
      |> Enum.all?()

    if valid_game?, do: game_id, else: 0
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

  def group_draws_by_color(draws) do
    Enum.group_by(draws, fn draw -> String.split(draw) |> List.last() end)
  end

  def lowest_possible_cubes(%{"blue" => blue_draws, "red" => red_draws, "green" => green_draws}) do
    min_blues =
      sort_draws(blue_draws)
      |> Enum.max()

    min_reds =
      sort_draws(red_draws)
      |> Enum.max()

    min_greens =
      sort_draws(green_draws)
      |> Enum.max()

    %{blue: min_blues, red: min_reds, green: min_greens}
  end

  def cube_product(cubes) do
    Map.values(cubes)
    |> Enum.product()
  end

  def sort_draws(draws) do
    Enum.map(draws, &String.split(&1))
    |> Enum.map(&List.first/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort()
  end
end
