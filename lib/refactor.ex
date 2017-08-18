defmodule Refactor do
  #import Logger, only: [info: 2, error: 2]

  @moduledoc """
  Utilities for refactoring Elixir files.
  """

  @doc """
  Generates list of patterns to pass to a find/replace function           
  including pluralized and upper/lower-case variations of the 
  provided from/to strings.

  ## Examples

      iex> Refactor.patterns("Comment", "Category")
      [
        ["Comments", "Categories"],
        ["Comment",  "Category"  ],
        ["comments", "categories"],
        ["comment",  "category"  ],
      ]

  """
  def patterns(from, to) do
    from = String.capitalize(from)
    to = String.capitalize(to)
    from_plural = Inflex.pluralize(from)
    to_plural = Inflex.pluralize(to)
    [
      [from_plural, to_plural],
      [from, to],
      [String.downcase(from_plural), String.downcase(to_plural)],
      [String.downcase(from), String.downcase(to)],
    ]
  end

  @doc """
  Opens file and find/replace each string pattern in the provided list.

  ## Examples

      iex> patterns = [["cat", "goat"], ["Cats", "Goats"]]
      iex> content = "Cats are the best pets. Have a cat?"
      iex> Refactor.replace(content, patterns)
      "Goats are the best pets. Have a goat?"

  """
  def replace(content, patterns) do
    Enum.reduce(patterns, content, fn(pattern, acc) -> 
      [from, to] = pattern
      String.replace(acc, from, to, global: true)
    end)
  end

  defp parse(filepath) do
    case File.read(filepath) do
      {:ok, body} -> body
      {:error, reason} -> raise reason
    end
  end

  defp save(content, filepath) do
    case File.open(filepath, [:write]) do
      {:ok, file} ->
        IO.binwrite file, content
        File.close file
      {:error, reason} -> raise reason
    end
  end

  @doc """
  Rename a constant in file, including the capitalized, lower-case,
  and plural variations of the string.
  """
  def rename(from, to, filepath) do
    strings = patterns(from, to)
    parse(filepath)
    |> replace(strings)
    |> save(filepath)
  end

  def main(args) do
    {options, _, _} = OptionParser.parse(args, 
      strict: [from: :string, to: :string, file: :string],
      aliases: [f: :from, t: :to, p: :file]
    )
    IO.puts "Elixir Refactor Utility"
    IO.puts "---"
    if length(options) == 3 do
      if File.exists?(options[:file]) do
        IO.puts Enum.join(["Renaming:", options[:from], "->", options[:to], "in", options[:file]], " ")
        rename(options[:from], options[:to], options[:file])
        IO.puts "Done."
      else
        IO.puts(Enum.join(["Error - File does not exist:", options[:file]]))
      end
    else
      IO.puts "Required arguments:\n\n\t\t--from, -f\n\t\t--to, -t\n\t\t--file, -f\n"
      IO.puts "For example:\n"
      IO.puts "\t\t./refactor --from Comment --to Category --file ./sample_test.ex\n"
      IO.puts "\t\t./refactor -f Comment -t Category -p ./sample_test.ex\n"
    end
  end
end
