defmodule Year2023.Day05 do
  @moduledoc """
  I threw in the towel on part 2. Part 1 was my own solution and can be found
  at commit 1759e00f.

  The refactors are courtesy of the following post on the elixir forum:
  https://elixirforum.com/t/advent-of-code-2023-day-5/60170/2

  Looking at this solution (and others) in the thread have been a wonderful
  learning experience. Idiomatic Elixir requires a certain kind of mindset, and
  I don't have that sixth sense for things like pattern matching, guard clauses,
  and the like (yet).
  """
  defstruct [
    :destination_start,
    :source_start,
    :range_length
  ]

  def full_part_1() do
    InputHelper.input_for(2023, 5)
    |> part_1()
  end

  def part_1(lines) do
    segments = line_segments(lines)
    seeds = get_seeds(segments)

    calc_lowest_location(segments, seeds)
  end

  def part_2(lines) do
    segments = line_segments(lines)
    seeds = seeds_from_ranges(segments)

    calc_lowest_location(segments, seeds)
  end

  def calc_lowest_location(segments, seeds) do
    seed_to_soil_maps = seed_to_soil_maps(segments)
    soil_to_fertilizer_maps = soil_to_fertilizer_maps(segments)
    fertilizer_to_water_maps = fertilizer_to_water_maps(segments)
    water_to_light_maps = water_to_light_maps(segments)
    light_to_temperature_maps = light_to_temperature_maps(segments)
    temperature_to_humidity_maps = temperature_to_humidity_maps(segments)
    humidity_to_location_maps = humidity_to_location_maps(segments)

    Enum.map(seeds, &calc_from_maps(seed_to_soil_maps, &1))
    |> Enum.map(&calc_from_maps(soil_to_fertilizer_maps, &1))
    |> Enum.map(&calc_from_maps(fertilizer_to_water_maps, &1))
    |> Enum.map(&calc_from_maps(water_to_light_maps, &1))
    |> Enum.map(&calc_from_maps(light_to_temperature_maps, &1))
    |> Enum.map(&calc_from_maps(temperature_to_humidity_maps, &1))
    |> Enum.map(&calc_from_maps(humidity_to_location_maps, &1))
    |> Enum.min()
  end

  def line_segments(raw_file_input) do
    String.split(raw_file_input, "\n\n")
  end

  def get_seeds(line_segments) do
    hd(line_segments)
    |> String.trim("seeds: ")
    |> split_into_integers()
  end

  def seeds_from_ranges(segments) do
    hd(segments)
    |> String.trim("seeds: ")
    |> split_into_integers()
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start, len] -> Enum.to_list(start..(start + len)) end)
    |> Enum.concat()
  end

  def calc_from_maps(maps, item) do
    Enum.find(maps, fn map ->
      in_source_range?(map, item)
    end)
    |> calc_destination(item)
  end

  def calc_destination(nil, item), do: item

  def calc_destination(map, item) do
    offset = item - map.source_start

    map.destination_start + offset
  end

  def in_source_range?(map, item) do
    map.source_start <= item && item <= map.source_start + map.range_length
  end

  def seed_to_soil_maps(line_segments) do
    Enum.filter(line_segments, &String.starts_with?(&1, "seed-to-soil map:"))
    |> hd()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&build_source_map/1)
  end

  def soil_to_fertilizer_maps(line_segments) do
    Enum.filter(line_segments, &String.starts_with?(&1, "soil-to-fertilizer map:"))
    |> hd()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&build_source_map/1)
  end

  def fertilizer_to_water_maps(line_segments) do
    Enum.filter(line_segments, &String.starts_with?(&1, "fertilizer-to-water map:"))
    |> hd()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&build_source_map/1)
  end

  def water_to_light_maps(line_segments) do
    Enum.filter(line_segments, &String.starts_with?(&1, "water-to-light map:"))
    |> hd()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&build_source_map/1)
  end

  def light_to_temperature_maps(line_segments) do
    Enum.filter(line_segments, &String.starts_with?(&1, "light-to-temperature map:"))
    |> hd()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&build_source_map/1)
  end

  def temperature_to_humidity_maps(line_segments) do
    Enum.filter(line_segments, &String.starts_with?(&1, "temperature-to-humidity map:"))
    |> hd()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&build_source_map/1)
  end

  def humidity_to_location_maps(line_segments) do
    Enum.filter(line_segments, &String.starts_with?(&1, "humidity-to-location map:"))
    |> hd()
    |> String.split("\n")
    |> Enum.drop(1)
    |> Enum.map(&build_source_map/1)
  end

  defp build_source_map(str) do
    [dest, source, len] = split_into_integers(str)

    %Year2023.Day05{
      destination_start: dest,
      source_start: source,
      range_length: len
    }
  end

  defp split_into_integers(str) do
    String.split(str)
    |> Enum.map(&String.to_integer/1)
  end

  # Everything below this comment is from the Elixir Forum post.

  def parse_input(input) do
    blocks = input |> String.trim_trailing() |> String.split("\n\n")

    [
      "seeds: " <> seeds_raw,
      "seed-to-soil map:\n" <> seed_to_soil_raw,
      "soil-to-fertilizer map:\n" <> soil_to_fertilizer_raw,
      "fertilizer-to-water map:\n" <> fertilizer_to_water_raw,
      "water-to-light map:\n" <> water_to_light_raw,
      "light-to-temperature map:\n" <> light_to_temperature_raw,
      "temperature-to-humidity map:\n" <> temperature_to_humidity_raw,
      "humidity-to-location map:\n" <> humidity_to_location_raw
    ] = blocks

    %{
      seeds: int_list(seeds_raw),
      seed_to_soil: parse_ranges(seed_to_soil_raw),
      soil_to_fertilizer: parse_ranges(soil_to_fertilizer_raw),
      fertilizer_to_water: parse_ranges(fertilizer_to_water_raw),
      water_to_light: parse_ranges(water_to_light_raw),
      light_to_temperature: parse_ranges(light_to_temperature_raw),
      temperature_to_humidity: parse_ranges(temperature_to_humidity_raw),
      humidity_to_location: parse_ranges(humidity_to_location_raw)
    }
  end

  defp int_list(line) do
    line
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp parse_ranges(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&parse_range/1)
  end

  defp parse_range(line) do
    [dest_start, source_start, len] = int_list(line)

    source_range = source_start..(source_start + len - 1)//1
    dest_range = dest_start..(dest_start + len - 1)//1
    {source_range, dest_range}
  end

  def forum_part_one(problem) do
    locations = Enum.map(problem.seeds, &find_location(&1, problem))
    Enum.min(locations)
  end

  @path [
    :seed_to_soil,
    :soil_to_fertilizer,
    :fertilizer_to_water,
    :water_to_light,
    :light_to_temperature,
    :temperature_to_humidity,
    :humidity_to_location
  ]

  # For each seed, pass it through each map to find the location using the `translate` function.
  # The `seed` binding here is the accumulator. After each pass, it becomes the new source value for the next level of
  # the mapping.
  defp find_location(seed, data) do
    Enum.reduce(@path, seed, fn tl_key, id -> translate(Map.fetch!(data, tl_key), id) end)
  end

  # For each set of ranges (`ranges`), check if `id` (the mapped seed value to this point) is in a source range.
  # If so, calculate the destination value.
  # Otherwise, return the number unchanged.
  defp translate(ranges, id) do
    case Enum.find(ranges, fn {source_range, _dest_range} -> id in source_range end) do
      {source_range, dest_range} ->
        diff = id - source_range.first
        dest_range.first + diff

      nil ->
        id
    end
  end

  def forum_part_two(problem) do
    # Create the seed ranges
    ranges =
      problem.seeds
      |> Enum.chunk_every(2)
      |> Enum.map(fn [first, last] -> first..(first + last - 1) end)

    # Reduce through the mapping paths as before.
    # `ranges` is now the accumulator.
    final_ranges = Enum.reduce(@path, ranges, &translate_ranges(Map.fetch!(problem, &1), &2))

    Enum.min_by(final_ranges, & &1.first).first
  end

  defp translate_ranges(mappers, ranges) do
    # For each mapper, split all the ranges into those that are covered by the
    # mapper source and those that are not. The latter can be consumed by the
    # next mapper and so on.
    #
    # Finally return the covered ranges translated by the mapper and the
    # leftover as-is, as they are valid ranges but map 1:1.

    dbg(mappers)
    dbg(ranges)

    Enum.flat_map_reduce(mappers, ranges, fn {source, _} = mapper, rest_ranges ->
      {covered_ranges, rest_ranges} = split_ranges(rest_ranges, source)
      {Enum.map(covered_ranges, &translate_range(&1, mapper)), rest_ranges}
    end)
    |> case do
      {translated, as_is} -> translated ++ as_is
    end
  end

  defp translate_range(range, {source, dest}) do
    diff = dest.first - source.first
    Range.shift(range, diff)
  end

  defp split_ranges(ranges, source) do
    split_ranges(ranges, source, {[], []})
  end

  defp split_ranges([r | ranges], source, {covered_ranges, rest_ranges}) do
    case split_range(r, source) do
      {nil, rest} ->
        split_ranges(ranges, source, {covered_ranges, rest ++ rest_ranges})

      {covered, nil} ->
        split_ranges(ranges, source, {covered ++ covered_ranges, rest_ranges})

      {covered, rest} ->
        split_ranges(ranges, source, {covered ++ covered_ranges, rest ++ rest_ranges})
    end
  end

  defp split_ranges([], _source, acc) do
    acc
  end

  def split_range(range, source)

  def split_range(range_start.._range_end = range, _source_start..source_end)
      when source_end < range_start do
    {nil, [range]}
  end

  def split_range(_range_start..range_end = range, source_start.._source_end)
      when source_start > range_end do
    {nil, [range]}
  end

  def split_range(range_start..range_end = range, source_start..source_end)
      when source_start <= range_start and source_end >= range_end do
    {[range], nil}
  end

  def split_range(range_start..range_end, source_start..source_end)
      when source_start >= range_start and source_end >= range_end do
    {[source_start..range_end], [range_start..(source_start - 1)]}
  end

  def split_range(range_start..range_end, source_start..source_end)
      when source_start <= range_start and source_end <= range_end do
    {[range_start..source_end], [(source_end + 1)..range_end]}
  end

  def split_range(range_start..range_end, source_start..source_end)
      when source_start >= range_start and source_end <= range_end do
    {[source_start..source_end], [range_start..(source_start - 1), (source_end + 1)..range_end]}
  end
end
