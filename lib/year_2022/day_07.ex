defmodule Year2022.Day07 do
  def part_1(["$ cd /", "$ ls" | tail]) do
    %{
      type: :directory,
      name: "/",
      contents: build_directory_contents(["$ cd /", "$ ls" | tail])
    }
  end

  def directory_size(%{type: :directory, name: _, contents: contents}) do
    Enum.reduce(contents, 0, fn file, acc -> acc + file.size end)
  end

  def build_directory(input) do
    [cd_command, "$ ls" | _tail] = input

    %{
      type: :directory,
      name: get_directory_name(cd_command),
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

      Map.put(dir, :contents, contents)
    else
      build_file(child_str)
    end
  end

  def build_file(file_str) do
    [size, name] = String.split(file_str)
    %{type: :file, name: name, size: String.to_integer(size)}
  end

  def get_directory_name(cd_command) do
    String.trim(cd_command, "$ cd ")
  end

  def child_dir_input(%{type: :directory, name: name}, input) do
    index = Enum.find_index(input, fn x -> x == "$ cd #{name}" end)
    Enum.drop(input, index)
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
