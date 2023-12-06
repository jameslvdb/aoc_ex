defmodule Year2023.Day05 do
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
end
