defmodule Year2022.Day07Test do
  use ExUnit.Case
  alias Year2022.Day07

  test "locations" do
    Day07.add_current_dir_to_lines(test_input())
  end

  describe "new build file tree" do
    test "base root case" do
      input = [
        "$ cd /",
        "$ ls",
        "100 a",
        "200 b"
      ]

      assert Day07.new_build_file_tree(input) == %{
               type: :directory,
               name: "/",
               size: 300,
               contents: [
                 %{type: :file, name: "a", size: 100},
                 %{type: :file, name: "b", size: 200}
               ]
             }
    end

    test "one file and one dir" do
      input = [
        "$ cd /",
        "$ ls",
        "100 a",
        "dir z",
        "$ cd z",
        "$ ls",
        "500 jlv"
      ]

      assert Day07.new_build_file_tree(input) == %{
               type: :directory,
               name: "/",
               size: 600,
               contents: [
                 %{type: :file, name: "a", size: 100},
                 %{
                   type: :directory,
                   name: "z",
                   size: 500,
                   contents: [
                     %{type: :file, name: "jlv", size: 500}
                   ]
                 }
               ]
             }
    end

    test "one file and multiple dirs" do
      input = [
        "$ cd /",
        "$ ls",
        "dir y",
        "100 a",
        "dir z",
        "$ cd y",
        "$ ls",
        "1000 y.txt",
        "$ cd ..",
        "$ cd z",
        "$ ls",
        "500 jlv"
      ]

      assert Day07.new_build_file_tree(input) == %{
               type: :directory,
               name: "/",
               size: 1600,
               contents: [
                 %{
                   type: :directory,
                   name: "y",
                   size: 1000,
                   contents: [
                     %{type: :file, name: "y.txt", size: 1000}
                   ]
                 },
                 %{type: :file, name: "a", size: 100},
                 %{
                   type: :directory,
                   name: "z",
                   size: 500,
                   contents: [
                     %{type: :file, name: "jlv", size: 500}
                   ]
                 }
               ]
             }
    end

    test "the problem child" do
      input = [
        "$ cd /",
        "$ ls",
        "dir foo",
        "dir bar",
        "100 a",
        "$ cd foo",
        "$ ls",
        "dir bar",
        "1000 y.txt",
        "$ cd bar",
        "$ ls",
        "5000 nested.txt",
        "$ cd ..",
        "$ cd ..",
        "$ cd bar",
        "$ ls",
        "500 jlv"
      ]

      assert Day07.new_build_file_tree(input) == %{
               type: :directory,
               name: "/",
               size: 6600,
               contents: [
                 %{
                   type: :directory,
                   name: "foo",
                   size: 6000,
                   contents: [
                     %{
                       type: :directory,
                       name: "bar",
                       size: 5000,
                       contents: [
                         %{type: :file, name: "nested.txt", size: 5000}
                       ]
                     },
                     %{type: :file, name: "y.txt", size: 1000}
                   ]
                 },
                 %{
                   type: :directory,
                   name: "bar",
                   size: 500,
                   contents: [
                     %{type: :file, name: "jlv", size: 500}
                   ]
                 },
                 %{type: :file, name: "a", size: 100}
               ]
             }
    end
  end

  describe "part 2" do
    test "the smallest dir we can delete" do
      assert Day07.part_2(test_input()) == 24_933_642
    end
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
