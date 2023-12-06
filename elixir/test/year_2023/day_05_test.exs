defmodule Year2023.Day05Test do
  alias Year2023.Day05
  use ExUnit.Case

  @test_lines InputHelper.example_input_for(2023, 5, 1)

  describe "example cases" do
    test "part 1 example" do
      assert Day05.part_1(@test_lines) == 35
    end

    @tag :skip
    test "part 2 example" do
      assert Day05.part_2(@test_lines) == 46
    end
  end

  test "get_seeds" do
    segments = Day05.line_segments(@test_lines)
    assert Day05.get_seeds(segments) == [79, 14, 55, 13]
  end

  test "line segments" do
    assert Day05.line_segments(@test_lines) == [
             "seeds: 79 14 55 13",
             "seed-to-soil map:\n50 98 2\n52 50 48",
             "soil-to-fertilizer map:\n0 15 37\n37 52 2\n39 0 15",
             "fertilizer-to-water map:\n49 53 8\n0 11 42\n42 0 7\n57 7 4",
             "water-to-light map:\n88 18 7\n18 25 70",
             "light-to-temperature map:\n45 77 23\n81 45 19\n68 64 13",
             "temperature-to-humidity map:\n0 69 1\n1 0 69",
             "humidity-to-location map:\n60 56 37\n56 93 4"
           ]
  end

  test "seed_to_soil" do
    segments = Day05.line_segments(@test_lines)

    assert Day05.seed_to_soil_maps(segments) == [
             %Day05{
               #  destination_range: 50..51,
               destination_start: 50,
               #  source_range: 98..99,
               source_start: 98,
               range_length: 2
             },
             %Day05{
               #  destination_range: 52..99,
               destination_start: 52,
               #  source_range: 50..97,
               source_start: 50,
               range_length: 48
             }
           ]
  end

  test "given a seed number, it gets the right soil number" do
    segments = Day05.line_segments(@test_lines)
    seed_to_soil_maps = Day05.seed_to_soil_maps(segments)

    assert Day05.calc_from_maps(seed_to_soil_maps, 14) == 14
    assert Day05.calc_from_maps(seed_to_soil_maps, 99) == 51
  end

  describe "calc_destination" do
    test "should return the given number when map is nil" do
      assert Day05.calc_destination(nil, 19) == 19
    end
  end
end
