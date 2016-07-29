# Chapter 7: Unix Data Tools
### July 22, 2016
#### Corey Carter and Felipe Reyes 

***

## Unix one-liner approach
#### Connect several Unix tools with pipes "|" to develop tiny programs. 
- Build small modules (Unix design philosophy)
- Reusable Unix data tools 
- For example: `$ cat input.txt | tr -cs A-Za-z '\n' | tr A-Z a-z | sort | uniq -c | sort -rn | sed 10q`
- `Open file | Create one-word lines | Uppercase to lowercase | Sort | Remove duplicates | Sort in reverse numeric order |  Print the first 10 lines`

***

## When to use the one-liner approach
Ask yourself, what do I need? Quick answers for specific simple tasks or thorough answers for large complex tasks?

 Good for | Lacking for
 --- | ---
Low-level data manipulation or exploration | Flexibility to control input data
Transforming data between formats | Structuring programs
Inspecting data for potential problems | Code documentation 

- Document your successful one-liners! (A script could be a good place to do it) 

***

## Manipulating text data
- General goal: manipulate plain-text files or streams using Unix data tools
- Bioinformatics favors tab-delimited data 
    - BED, GTF/GFF, SAM, VCF, tabular BLAST output
- Some formatting
    - Row = Record
    - Field = Column
    - A single tab character = `/t` 

*** 

#### `Head` and `tail`
- Inspect data
- Control amount of lines with the argument `-n`
- Use `head` to check you are working on the correct file (Useful at the end of a pipe)
- Chop headers with tail (+x)
    - `tail -n +2 sample.bed`
    - Is this approach robust?...will it work on other files?
*** 
#### `Less`
- More like an application than a command
- Allows highlighting 
- Useful to debug and inspect pipes at different instances
- `q` to quit, `h` for help
*** 
#### Useful `less` shortcuts

 Shortcut | Action
 --- | ---
`space bar` | Next page
`b` | Previous page
`g` | First line
`G` | Last line
`j` | Down one line
`k` | Up one line
`\<pattern>` | Search down for string
`?<pattern>` | Search up for string

*** 

#### Plain text data summary
- `wc` (Word count) by default outputs: `Words Lines Characters`
    - Note: number of lines is not the same as number of rows 
- `ls -lh` for human-readable file sizes
- `awk` to process tabular plain-text data (more ahead)

*** 

#### Using `cut` and `column` to work with column data
- Cuts specific fields (columns)
    - Use `-f <field(s)>` to specify a column, a range of columns(-), or a set of columns(,) 
    - Sometimes the headings and the content in each column don't align well 
- Using `column` can help us solve this issue
    - Should only be used for visualizing data in terminal
    - `-s","` to work with CSV files

*** 

#### `Grep` 
- *"Faster than any Python script"*, *"The most powerful tool of Unix"*
- Tip: use "quotes" around the pattern to prevent Unix from interpreting any symbols
- For more context 

Argument | Action
--- | ---
-B | context before  
-A | context after 
-C | context before and after 

***

#### More on `grep`

- Regular expressions 
    - Basic (BRE)
        - []
    - Extended (ERE)
        - (|)
        - Sometimes aliased to `egrep`
- To count how many lines match a pattern use `-c` 
- To only extract the matching part of the pattern (instead of the whole line) use `-o`

*** 

#### Decoding plain-text data
- To see what kind of file we are dealing with use `file`
    - ASCII text, ASCII text, with very long lines, UTF-8 Unicode English text
- `hexdump`returns the hexadecimal values of each character

- In general `file`, `hexdump`, and `grep` are useful for those situations where something isn’t behaving correctly and you suspect a file’s encoding may be to blame

***

#### Sorting plain-text data with `sort`
- Sorted data is operations-friendly
- Necessary for finding unique lines
- For CSV files include `-t","`
- Sorting keys `-k` syntax
    - Each `-k` arguments takes a range of columns as `start,end` 
    - A second `-k` argument tells  `sort` how to break any ties
    - For numerical data include `n` after `end`
***

#### Finding unique values with `uniq`
- If not sorted, `uniq` only removes duplicate lines
- Add the option `-i` to make `uniq` case sensitive
- Use `-c` to count the number of repeats of each unique line 

***

#### Text processing with `awk`
- Designed to work with tabular data
- Processes one record at the time
    - Each record = 1 line 
    - Each field = 1 column's entry for that record 
- Structure: pattern { action }
    - If pattern matches -> do action
    - No pattern = run the action on all records

***    

#### Stream editing using `sed`
- Beauty: edit large files without opening it in memory
- It's syntax is `s/pattern/replacement/`

