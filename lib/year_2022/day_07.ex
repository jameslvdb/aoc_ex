defmodule Year2022.Day07 do
  @doc """
  Read puzzle input from txt file and call part_1/1.
  """
  def full_part_1() do
    InputHelper.input_for(2022, 7)
    |> String.split("\n")
    |> part_1()
  end

  def part_1(["$ cd /", "$ ls" | _tail] = input) do
    new_build_file_tree(input)
    |> get_small_dirs()
  end

  def full_part_2() do
    InputHelper.input_for(2022, 7)
    |> String.split("\n")
    |> part_2()
  end

  def part_2(lines) do
    total_disk_space = 70_000_000
    required_disk_space = 30_000_000

    sorted_dir_sizes =
      new_build_file_tree(lines)
      |> directory_sizes()
      |> List.flatten()
      |> Enum.sort()
      |> Enum.reverse()

    free_disk_space = total_disk_space - hd(sorted_dir_sizes)
    need_to_free = required_disk_space - free_disk_space

    Enum.find(Enum.reverse(sorted_dir_sizes), fn x -> x > need_to_free end)
  end

  def new_build_file_tree(lines) do
    lines_with_dirs = add_current_dir_to_lines(lines)

    initial_tree = %{
      type: :directory,
      name: "/",
      contents: contents_for_dir(["/"], lines_with_dirs)
    }

    Map.put(initial_tree, :size, get_dir_size(initial_tree))
  end

  @doc """
  Return a List of all lines where the line's location matches the given location.
  """
  def contents_for_dir(location, lines) do
    Enum.filter(lines, fn {loc, _line} ->
      loc == location
    end)
    |> parse_dir_contents(lines)
  end

  def parse_dir_contents(dir_lines, original_lines) do
    Enum.reject(dir_lines, fn {_loc, line} -> String.starts_with?(line, "$") end)
    |> Enum.map(fn x -> build_line(x, original_lines) end)
  end

  def build_line({location, line}, original_lines) do
    cond do
      String.starts_with?(line, "dir") ->
        # build directory, recur
        new_dir_name =
          String.split(line)
          |> Enum.at(-1)

        new_location = location ++ [new_dir_name]

        dir = %{
          type: :directory,
          name: new_dir_name,
          contents: contents_for_dir(new_location, original_lines)
        }

        Map.put(dir, :size, get_dir_size(dir))

      String.starts_with?(line, "$") ->
        nil

      true ->
        build_file(line)
    end
  end

  def get_dir_size(dir) do
    Enum.reduce(dir.contents, 0, fn x, acc -> x.size + acc end)
  end

  def get_small_dirs(file_tree) do
    directory_sizes(file_tree)
    |> List.flatten()
    |> Enum.reject(fn x -> x > 100_000 end)
    |> Enum.sort()
    |> Enum.sum()
    |> dbg()
  end

  def add_current_dir_to_lines(lines) do
    {lines, _} =
      Enum.map_reduce(lines, [], fn line, location -> track_location(line, location) end)

    Enum.map(lines, fn [dir, line] ->
      dir_str = Enum.reverse(dir)
      {dir_str, line}
    end)
  end

  def directory_sizes([]), do: []

  def directory_sizes(%{type: :directory, name: "/", contents: _} = file_tree) do
    [file_tree.size] ++ directory_sizes(file_tree.contents)
  end

  def directory_sizes(contents) do
    dirs = filter_directories(contents)
    new_contents = Enum.map(dirs, fn x -> x.contents end)

    sizes = Enum.map(dirs, fn x -> x.size end)

    sizes ++ Enum.map(new_contents, &directory_sizes/1)
  end

  defp filter_directories(list) do
    Enum.filter(list, fn x -> x.type == :directory end)
  end

  # this makes sense
  def build_file(file_str) do
    [size, name] = String.split(file_str)
    %{type: :file, name: name, size: String.to_integer(size)}
  end

  def track_location(line, location) do
    # location defaults to []
    cond do
      line == "$ cd .." ->
        new_loc = Enum.drop(location, 1)
        {[new_loc, line], new_loc}

      String.starts_with?(line, "$ cd") ->
        new_loc = [Enum.at(String.split(line), -1) | location]
        {[new_loc, line], new_loc}

      true ->
        {[location, line], location}
    end
  end
end

# Represent these as Maps:
%{
  type: :directory,
  name: "/",
  contents: [
    %{
      type: :directory,
      name: "a",
      contents: [
        %{
          type: :directory,
          name: "e",
          contents: [
            %{type: :file, name: "i", size: 584}
          ]
        },
        %{type: :file, name: "f", size: 29116},
        %{type: :file, name: "g", size: 2557},
        %{type: :file, name: "h.lst", size: 62596}
      ]
    },
    %{type: :file, name: "b.txt", size: 14_848_514},
    %{type: :file, name: "c.dat", size: 8_504_156},
    %{
      type: :directory,
      name: "d",
      contents: [
        %{type: :file, name: "j", size: 4_060_174},
        %{type: :file, name: "d.log", size: 8_033_020},
        %{type: :file, name: "d.ext", size: 5_626_152},
        %{type: :file, name: "k", size: 7_214_296}
      ]
    }
  ]
}

{"/",
 [
   {"a",
    [
      {"e",
       [
         {"i", 584}
       ]},
      {"f", 29116},
      {"g", 2557},
      {"h.lst", 62596}
    ]}
 ]}
