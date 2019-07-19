# Git Log

```
commit fe59549d0248d174ff20115237bc4097952c9024
Author: Clare Lanam 🐿 <clare@squareup.com>
Date:   Wed Jul 17 23:19:44 2019 -0700

    add nuclear family tests
    
    gosh dangit. none of the family building works like i expected and now i'm out of time. T___T
    
    The code cannot even find people I added to it--but randomly?
```

# CLOC


cloc|github.com/AlDanial/cloc v 1.82  T=0.08 s (539.1 files/s, 25812.2 lines/s)
--- | ---

Language|files|blank|comment|code
:-------|-------:|-------:|-------:|-------:
Ruby|32|269|181|1266
Markdown|7|70|0|126
Bourne Again Shell|1|6|0|35
JSON|1|0|0|27
YAML|1|6|10|15
--------|--------|--------|--------|--------
SUM:|42|351|191|1469

# Spec Results
## Fam

```

Fam
  dev apology
    Sorry, rspec is new to me and I did not have my laptop for half the week. \
        Please forgive weirdness!
  add_person
    adding a person
      returns a success message
      returns a SUCCESS_CODE status
    falling asleep on the keyboard and repeatedly adding the person
      raises a DuplicatePerson error
  get_person
    when the area is deserted of people
      returns an error
      returns an ERROR_CODE status
    when the person exists
      returns no error
      returns the person
      returns a SUCCESS_CODE status
  add_parents
    when no one exists
      returns an error for one of the so-called people involved
      returns no output
      returns an ERROR_CODE status
    when the child does not exist
      returns an error for the child being AWOL
      returns no output
      returns an ERROR_CODE status
    when the parents do not exist
      returns an error for the child being AWOL
      returns no output
      returns an ERROR_CODE status
    when everyone exists
      returns no error
      returns a success message about the adoption
      returns a SUCCESS_CODE status
    too many parents
      returns an error for third gene-donor (no non-traditional \
          adoptions/mitochrondria donations)
      returns an error message about the adoption
  families
    nuclear
      returns parents of father correctly
    narcissism
      is a valid means of reproduction
    parthenogenesis
      is a valid means of reproduction
    spontaneous generation
      is a valid means of reproduction
    time travel
      is a valid means of reproduction

Finished in 0.05938 seconds (files took 0.67879 seconds to load)
28 examples, 0 failures

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

Finished in 14.46 seconds (files took 0.50837 seconds to load)
20 examples, 0 failures

```

