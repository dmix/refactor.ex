defmodule RefactorTest do
  use ExUnit.Case
  doctest Refactor

  @from   "Comment"
  @to     "Category"
  @patterns [
    ["Comments", "Categories"],
    ["Comment",  "Category"],
    ["comments", "categories"],
    ["comment",  "category"]
  ]
  @sample "./test/samples/example.ex"
  @input  "./test/samples/example_input.ex"
  @output "./test/samples/example_refactored.ex"

  test "generates patterns" do
    assert Refactor.patterns(@from, @to) == @patterns
  end

  test "replaces strings in file" do
    {:ok, input}  = File.read @sample
    refute Refactor.replace(input, @patterns) =~ @from
  end

  test "renames file contents" do
    :ok = File.cp(@sample, @input) # Prepare clean test file
    :ok = Refactor.rename(@from, @to, @input)
    {:ok, input}  = File.read @input
    {:ok, output} = File.read @output
    on_exit(:cleanup, fn -> :ok = File.rm(@input) end)
    assert input == output
  end
end
