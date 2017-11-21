defmodule PositiveCompoundNameRefactorTest do
  use ExUnit.Case
  doctest Refactor

  @from   "User"
  @to     "Admin"
  @patterns [
    ["Users", "Admins"],
    ["User",  "Admin"],
    ["users", "admins"],
    ["user",  "admin"]
  ]
  @sample "./test/samples/positive_compound_example.ex"
  @input  "./test/samples/positive_compound_example_input.ex"
  @output "./test/samples/positive_compound_example_refactored.ex"

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
