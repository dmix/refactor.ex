# :crystal_ball: Refactor.ex 

A commandline utility to make refactoring projects easier. Currently the primary use-case is renaming constants/models/modules/etc. 

For example 

    ./refactor --from Tag --to Category --file ./example.ex

Would replace these strings in `example.ex`:

    Tag  -> Category
    Tags -> Categories 
    tag  -> category
    tags -> categories

### Features

[x] Rename models/constants
[ ] Accept glob patterns to process multiple files 
[ ] Process each file async
[ ] Also rename filenames (optionally)
[ ] Print count of strings that were replaced 
[ ] Rename functions

## Example

Renaming:

The utility generates all variations of "from" and "to" including Capitalization, 
lowercase, and pluralization to make sure each gets replaced. For example:

      iex> Refactor.patterns("Comment", "Category")
      [
        ["Comments", "Categories"],
        ["Comment",  "Category"  ],
        ["comments", "categories"],
        ["comment",  "category"  ],
      ]

The above happens automatically when you call `rename` on a file:

      iex> Refactor.rename("Comment", "Category", "./sample_test.ex")
      Done

## Installation

    git clone https://github.com/dmix/refactor.ex
    cd refactor.ex
    make

Use program in the current directory:

    ./refactor --from A --to B --file ./sample_test.ex

Or install to /usr/local/bin/refactor

    make install

## Usage

    Required arguments:

                    --from, -f = Name of existing model/contant to rename
                    --to, -t   = Name of new constant to replace it with
                    --file, -f = File to replace strings in

    For example:

                    ./refactor --from Comment --to Category --file ./sample_test.ex

                    ./refactor -f Comment -t Category -p ./sample_test.ex


## License

GNU v3

By Daniel P. McGrady - https://dmix.ca

