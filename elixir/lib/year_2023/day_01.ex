defmodule Year2023.Day01 do
  def full_part_1() do
    InputHelper.input_for(2023, 1)
    |> String.split("\n")
    |> part_1()
  end

  def part_1(lines) do
    Enum.map(lines, fn line -> numbers_in_line(line, :p1) end)
    |> Enum.reduce(0, fn line, acc -> acc + line_value(line) end)
  end

  def full_part_2() do
    InputHelper.input_for(2023, 1)
    |> String.split("\n")
    |> part_2()
  end

  def part_2(lines) do
    Enum.map(lines, fn line -> number_for_line(line) end)
    |> Enum.sum()
  end

  def line_value([]) do
    nil
  end

  def line_value([foo]) do
    String.to_integer(foo <> foo)
  end

  def line_value(line) do
    [first | rest] = line
    last = Enum.reverse(rest)

    result =
      (first <> Enum.at(last, 0))
      |> String.to_integer()
  end

  def numbers_in_line(line, :p1) do
    String.graphemes(line)
    |> Enum.filter(fn x -> x in valid_numbers(:p1) end)
  end

  def numbers_by_index(str) do
    Regex.scan(~r/\d|one|two|three/, str, return: :index)
  end

  def first_number(str) do
    regex = ~r/\d|one|two|three|four|five|six|seven|eight|nine|zero/

    Regex.run(regex, str)
    |> Enum.at(0)
    |> string_to_number()
  end

  def last_number(str) do
    regex = ~r/\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin|orez/

    Regex.run(regex, String.reverse(str))
    |> Enum.at(0)
    |> String.reverse()
    |> string_to_number()
  end

  def number_for_line(str) do
    (first_number(str) <> last_number(str))
    |> String.to_integer()
  end

  def valid_numbers(:p1) do
    ~w(1 2 3 4 5 6 7 8 9 0)
  end

  def valid_numbers(:p2) do
    ~w(1 2 3 4 5 6 7 8 9 0 one two three four five six seven eight nine zero)
  end

  def valid_chars() do
    ~w(1 2 3 4 5 6 7 8 9 0 e f g h i n o r s t u v w x z)
  end

  def string_to_number(x) when x in ~w(1 2 3 4 5 6 7 8 9 0), do: x

  def string_to_number(x) do
    numbers = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9",
      "zero" => "0"
    }

    {:ok, str} = Map.fetch(numbers, x)

    str
  end
end
