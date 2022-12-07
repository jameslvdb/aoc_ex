defmodule Year2022.Day07Test do
  use ExUnit.Case
  alias Year2022.Day07

  test "find directory size" do
    directory = %{
      type: :directory,
      name: "d",
      contents: [
        %{type: :file, name: "j", size: 4_060_174},
        %{type: :file, name: "d.log", size: 8_033_020},
        %{type: :file, name: "d.ext", size: 5_626_152},
        %{type: :file, name: "k", size: 7_214_296}
      ]
    }

    assert Day07.directory_size(directory) == 24_933_642
  end

  test "get directory name" do
    assert Day07.get_directory_name("$ cd abc") == "abc"
    assert Day07.get_directory_name("$ cd gienoceiw") == "gienoceiw"
  end

  test "builds directory" do
    input = [
      "$ cd d",
      "$ ls",
      "4060174 j",
      "8033020 d.log",
      "5626152 d.ext",
      "7214296 k",
      "$ cd .."
    ]

    assert Day07.build_directory(input) == %{
             type: :directory,
             name: "d",
             contents: [
               %{type: :file, name: "j", size: 4_060_174},
               %{type: :file, name: "d.log", size: 8_033_020},
               %{type: :file, name: "d.ext", size: 5_626_152},
               %{type: :file, name: "k", size: 7_214_296}
             ]
           }
  end

  describe "builds directory contents" do
    test "with only files" do
      input = [
        "$ cd d",
        "$ ls",
        "4060174 j",
        "8033020 d.log",
        "5626152 d.ext",
        "7214296 k",
        "$ cd .."
      ]

      assert Day07.build_directory_contents(input) == [
               %{type: :file, name: "j", size: 4_060_174},
               %{type: :file, name: "d.log", size: 8_033_020},
               %{type: :file, name: "d.ext", size: 5_626_152},
               %{type: :file, name: "k", size: 7_214_296}
             ]
    end

    test "with a child directory" do
      input = [
        "$ cd d",
        "$ ls",
        "4060174 j",
        "8033020 d.log",
        "5626152 d.ext",
        "7214296 k",
        "dir z",
        "$ cd z",
        "$ ls",
        "4734 y"
      ]

      assert Day07.build_directory_contents(input) == [
               %{type: :file, name: "j", size: 4_060_174},
               %{type: :file, name: "d.log", size: 8_033_020},
               %{type: :file, name: "d.ext", size: 5_626_152},
               %{type: :file, name: "k", size: 7_214_296},
               %{
                 type: :directory,
                 name: "z",
                 contents: [
                   %{type: :file, name: "y", size: 4734}
                 ]
               }
             ]
    end
  end

  test "child dir input" do
    assert Day07.child_dir_input(%{type: :directory, name: "d"}, test_input) == [
             "$ cd d",
             "$ ls",
             "4060174 j",
             "8033020 d.log",
             "5626152 d.ext",
             "7214296 k"
           ]
  end

  test "test input" do
    assert Day07.part_1(test_input) == %{
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
  end

  def test_input() do
    [
      "$ cd /",
      "$ ls",
      "dir a",
      "14848514 b.txt",
      "8504156 c.dat",
      "dir d",
      "$ cd a",
      "$ ls",
      "dir e",
      "29116 f",
      "2557 g",
      "62596 h.lst",
      "$ cd e",
      "$ ls",
      "584 i",
      "$ cd ..",
      "$ cd ..",
      "$ cd d",
      "$ ls",
      "4060174 j",
      "8033020 d.log",
      "5626152 d.ext",
      "7214296 k"
    ]
  end
end
