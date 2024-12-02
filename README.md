# Advent of Code

This repository contains solutions for Advent of Code problems in Elixir.

The `InputHelper` module can help solve using your full puzzle inputs by placing
the input in the `inputs/` directory under the proper `year` folder. For
example, to get the input for Day 1 in 2024, you should place the puzzle input
in a file named `inputs/year_2024/day_01.txt`. You can then do the following to
get the input in your code:

```elixir
defmodule Year2024.Day01 do
  def solve_part_1() do
    InputHelper.input_for(2024, 1)
    |> part_1()
  end
end
```

I like separating my input this way so that I can pass the example inputs into
my `part_1` and `part_2` functions to validate my solution before trying the
full input.

Example inputs can be added in a similar fashion: the filename should be
`inputs/year_2024/day_01_part_01_example.txt` and can be accessed with
`InputHelper.example_input_for/3`.
