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
  @sample "./sample.ex"
  @input  "./sample_input.ex"
  @output "./sample_refactored.ex"

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
    assert input == output
    :ok = File.rm(@input)
  end
end
