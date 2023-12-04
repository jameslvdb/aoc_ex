defmodule Year2023.Day04 do
  def full_part_1() do
    InputHelper.input_for(2023, 4)
    |> String.split("\n")
    |> part_1()
  end

  def part_1(lines) do
    Enum.map(lines, &game_numbers/1)
    |> Enum.map(&find_winners/1)
    |> Enum.map(&score_of_game/1)
    |> Enum.sum()
  end

  def full_part_2() do
    InputHelper.input_for(2023, 4)
    |> String.split("\n")
    |> part_2()
  end

  def part_2(lines) do
    game_state = %{}

    Enum.reduce(lines, game_state, fn line, state ->
      preprocessed_card = preprocess_card(line)
      process_card(state, preprocessed_card)
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def preprocess_card(line) do
    card_structure = %{game_id: nil, winning_numbers: nil, my_numbers: nil}

    card_structure = Map.put(card_structure, :game_id, game_id(line))
    [winning_numbers, my_numbers] = game_numbers(line)
    card_structure = Map.put(card_structure, :winning_numbers, winning_numbers)
    Map.put(card_structure, :my_numbers, my_numbers)
  end

  def process_card(game_state, %{game_id: id, winning_numbers: winning_nums, my_numbers: my_nums}) do
    game_state = count_initial_card(game_state, id)

    winners = find_winners([winning_nums, my_nums])

    iterator = Range.to_list(1..Map.get(game_state, id))

    Enum.reduce(iterator, game_state, fn _x, state ->
      add_winners(state, id, winners)
    end)
  end

  def count_initial_card(game_state, id) do
    Map.update(game_state, id, 1, fn existing -> existing + 1 end)
  end

  def add_winners(game_state, id, winners) do
    number_of_winners(winners)
    |> cards_won(id)
    |> Enum.reduce(game_state, fn new_card, state ->
      Map.update(state, new_card, 1, fn x -> x + 1 end)
    end)

    # update game state for each new card won
  end

  def game_id(line) do
    [game_id, _numbers] = String.split(line, ": ")

    [id] = Regex.run(~r/\d+/, game_id)
    id
  end

  def game_numbers(line) do
    [_game_id, numbers] = String.split(line, ": ")

    String.split(numbers, "|")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split/1)
  end

  def find_winners([winning_numbers, my_numbers]) do
    Enum.filter(my_numbers, fn x ->
      Enum.find(winning_numbers, fn winner -> winner == x end) != nil
    end)
  end

  def number_of_winners(winning_numbers), do: length(winning_numbers)

  def score_of_game([]), do: 0

  def score_of_game(my_winners) do
    Integer.pow(2, length(my_winners) - 1)
  end

  def cards_won(0, _game_id), do: []

  def cards_won(number_of_winners, game_id) do
    id = String.to_integer(game_id)

    (id + 1)..(id + number_of_winners)
    |> Range.to_list()
    |> Enum.map(&to_string/1)
  end
end
