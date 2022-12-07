defmodule Year2022.Day07 do
  def full_part_1() do
    InputHelper.input_for(2022, 7)
    |> String.split("\n", trim: true)
  end

  def part_1(["$ cd /", "$ ls" | _tail] = input) do
    %{
      type: :directory,
      name: "/",
      contents: build_directory_contents(input)
    }
  end

  def build_directory_contents([_cd_command, "$ ls" | tail]) do
    Enum.take_while(tail, fn x -> !String.starts_with?(x, "$") end)
    |> Enum.map(fn x -> build_child(x, tail) end)
  end

  def build_child(child_str, input) do
    if String.starts_with?(child_str, "dir") do
      dir = %{type: :directory, name: String.trim(child_str, "dir ")}

      contents =
        dir
        |> child_dir_input(input)
        |> build_directory_contents()
        |> dbg()

      content_size =
        Enum.map(contents, fn x -> x.size end)
        |> Enum.sum()

      Map.put(dir, :contents, contents)
      |> Map.put(:size, content_size)
    else
      build_file(child_str)
    end
  end

  def build_file(file_str) do
    [size, name] = String.split(file_str)
    %{type: :file, name: name, size: String.to_integer(size)}
  end

  def child_dir_input(%{type: :directory, name: name}, input) do
    index = Enum.find_index(input, fn x -> x == "$ cd #{name}" end)
    Enum.drop(input, index)
  end

  def directory_size(%{type: :directory, name: _, contents: contents} = input) do
    size =
      Enum.map(contents, &item_size/1)
      |> Enum.map(fn {_, x} -> x end)
      |> Enum.sum()

    Map.put(input, :size, size)
  end

  def item_size(%{type: :file} = file), do: {:ok, file.size}

  def item_size(%{type: :directory, contents: _contents} = input) do
    dir_with_size = directory_size(input)

    {dir_with_size, dir_with_size.size}
  end

  def build_directory(input) do
    [cd_command, "$ ls" | _tail] = input

    %{
      type: :directory,
      name: get_directory_name(cd_command),
      contents: build_directory_contents(input)
    }
  end

  def get_directory_name(cd_command) do
    String.trim(cd_command, "$ cd ")
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
