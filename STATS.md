# Git Log

```
commit 5daa22bcc2af13f1b0fed26a02f53d933dc6a2bc
Author: Sebastian Sangervasi <ssangervasi@squareup.com>
Date:   Mon Jul 15 12:11:16 2019 -0700

    Copy in sourcerer code
```

# CLOC


cloc|github.com/AlDanial/cloc v 1.82  T=0.04 s (1136.7 files/s, 45996.5 lines/s)
--- | ---

Language|files|blank|comment|code
:-------|-------:|-------:|-------:|-------:
Ruby|32|225|181|989
Markdown|7|68|0|124
Bourne Again Shell|1|6|0|35
YAML|1|6|10|15
--------|--------|--------|--------|--------
SUM:|41|305|191|1163

# Spec Results
## Fam

```
No examples found.

Finished in 0.00018 seconds (files took 0.37613 seconds to load)
0 examples, 0 failures

```

## Boilerplate

```

Fam::CLI::Add::Parents
  when the child and parent names are given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when all names are missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Add::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when no name is provided
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Get::Parents
  when a child name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when the child name is missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::CLI::Get::Person
  when a name is given
    behaves like a successful command
      exits with a zero status code
      matches the expected output
  when the name is missing
    behaves like a failed command
      exits with a non-zero status code
      matches the expected error

Fam::File::Reader::JSONReader
  #read
    when the file does not exist
      raises an error
    when the file exists
      should be a kind of Hash

Fam::File::Writer::JSONWriter
  #write
    should be a kind of String
    modifies the specified file

Finished in 14.28 seconds (files took 0.49675 seconds to load)
20 examples, 0 failures

```

