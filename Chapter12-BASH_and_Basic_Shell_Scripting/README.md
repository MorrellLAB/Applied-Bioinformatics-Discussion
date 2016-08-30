<!-- background: #000100 -->
<!-- color: #F1F1F2-->
<!-- font: metronova -->

# BASH and Basic Shell Scripting
---

Paul Hoffman

Applied Bioinformatics Discussion

August 26<sup>th</sup>, 2016

***

# Exit Statuses
---

Exit statuses are thrown at the end of a command to say if the comamnd finished properly and if not, potential errors

Exit status of 0 means the command exited cleanly

Exit status of not 0 means that it didn't

We can check exit statues using `$?`

```shell
% echo hello # Simple command
hello
% echo $? # Get the exit status
0
% qwertyuiop # Garbage command
qwertyuiop: command not found
% echo $? # It may not always be this status
127
```

***

# Conditionals in BASH
---

| Command | Test |
| ------- | ---- |
| `-z` | Is variable empty |
| `-e` | Does variable exist in filespace |
| `-d` | Is variable in filespace and a directory |
| `-f` | Is variable in filespace and a file |
| `-h` | Is variable in filespace and a link |
| `-r` | Is variable in filespace and readable |
| `-w` | Is variable in filespace and writeable |
| `-x` | Is variable in filespace and executable |
| `=` or `-eq` | Are variables identical or equal |
| `!=` or `-ne` | Are variables not identical or non-equal |
| `-lt` or `-lt` | Is one variable less than or less than or equal to the other |
| `-gt` or `-ge` | Is one variable greater than or greater than or equal to the other |

***

# Conditionals in BASH

Tests are done with a double bracket `[[]]` and can be done with `if; then; else; fi` or `while; do; done` statements

```shell
% myVar=5
% if [[ $myVar -eq 3 ]]; then echo "Yes"; else echo "No"; fi
no
% i=0
% while [[ $i -lt 5 ]]; do echo $i; let "i++"; done
0
1
2
3
4
```

# Iterating in BASH
---

Iterations in BASH are done with a simple `for; do; done` construct

```shell
% for i in $(seq 5); do echo $i; done
1
2
3
4
5
```

We can iterate through many different things, including sequences and arrays

***

# Variables
---

Variables are a way to store not-yet-known values

```shell
myVar=
```

We can use variables to create dynamic scripts that work on a variety of data

Variables are called with a `$`

```shell
% i=10 # Assign '10' to i
% echo $i # Call the value of $i
10
% i="Hello World" # Reassign i to 'Hello World'
% echo $i # Call the value of $i again
Hello World
```

***

<!-- background: #F5F5DC-->
<!-- color: #000100-->
<!-- font: metronova-->

# Shell Quirks I: Variable Assignment
---

Variable assignment in BASH **is** whitespace sensitive:

```shell
i = 10 # Won't work, there it calls the command 'i' on the values '=' and '10'
i=10 # 'i' is now 10
```

***

<!-- background: #000100 -->
<!-- color: #F1F1F2-->
<!-- font: metronova -->

# Weird Variable Stuff
---

 - Setting default values

```shell
echo ${myVar:-"Hello World"} # Print the value of $myVar or "Hello World if $myVar is unset
```

 - Providing error messages for unset variables

```shell
echo ${myVar:?"myVar has not been set"} # Print the value of $myVar or an error message if $myVar is unset
```

 - Use alternate value for variable

```shell
echo ${myVar:+"Use this instead of '$myVar'"} # Print a message instead of $myVar if $myVar is set
```

***

<!-- background: #F5F5DC-->
<!-- color: #000100-->
<!-- font: metronova-->

# Shell Quirks II: Quotations
---

Different types of quotations mean different things in BASH
 - Single quotes `''` indicate a literal, no shell expansion
 - Double quotes `""` indicate a single value, but will perform shell expansion
 - No quotes indicate separate values

```shell
% myVar='Hello World'
% echo '$myVar'
$myVar
% echo "$myVar"
Hello World
% ls "*.txt *.pdf"
ls: cannot access '*.txt *.pdf': No such file or directory
% ls *.txt *.pdf
# some output depending on your directory contents
```


***

<!-- background: #000100 -->
<!-- color: #F1F1F2-->
<!-- font: metronova -->

# BASH Arrays
---

Arrays are a way to hold multiple values together
 - Make an array using `declare -a`
 - Access specific values of an array with `${arr[]}`
   - Entire array can be accessed with a `@` or `*` instead of a Number
   - `${arr[@]}`
 - Get the length of the array with `${#arr[@]}`

```shell
% declare -a myArray=(potato tomato lumbago)
% echo ${myArray} # Will only return first value
potato
% echo ${myArray[1]} # Get the SECOND value
tomato
% echo ${myArray[@]} # Get all values
potato tomato lumbago
% echo ${#myArray[@]} # Get the size
3
```

***

<!-- background: #F5F5DC-->
<!-- color: #000100-->
<!-- font: metronova-->

# Shell Quirks III: 0- and 1-Based Counting
---

Sometimes BASH starts counting at 1, other times it starts at 0

1-based
 - Files
 - Sequences

0-based
 - Arrays

***

<!-- background: #000100 -->
<!-- color: #F1F1F2-->
<!-- font: metronova -->

# The All-Powerful `$`
---

The `$` sigil has a wide variety of functions in BASH

```shell
$0 # Name of script/environment
$1, $2, etc # Positional arguments passed to shell script
$# # Number of arguments passed to script from command line
$* # All arguments returned as single value
$@ # All arguments returned as array
$myVar # Variable
${myArr} # An array or special variable expression
$(command) # Command substitution
$((9+8)) # Basic integer math

```

***

# Pipes and Redirects
---

Pipes and redirects send outputs to other commands, files, and standard error/out

```shell
if ! $(command -v samtools) > /dev/null 2>/ dev/null; then echo "SAMTools is not installed" >&2; exit; fi

find . | grep 'tomato'
```

***

# `find`
---

The `find` command is similar to `ls`, except:
 - `find` is recursive
 - `find` can distinguish types
 - `find` has a full regex engine
 - `find` can directly pass files to a command

# `find`

```shell
find . -name "*.txt" # Find all .txt files in this directory and all subdirectories
find $(pwd) -maxdepth 1 -name "*.fastq" > sample_list.txt # Find all FastQ files in this directory only and write as a list to 'sample_list.txt'
find ./samfiles -name "*bad*.sam" -exec rm {} \; # Find all bad SAM files and remove
```

***

# GNU Parallel
---

GNU Parallel allows for the processing of multiple items at once

```shell
parallel samtools index {} :::: sam_list.txt
```

Parallel processing is limited by system resources and program structure
 - Typical use of GNU Parallel is to take **single-threaded** applications and run an instance on every available core
 - More cores will result in more processes (can be limited in GNU Parallel)
 - Memory becomes a limiting factor when running multiple processes at once
 - *Multi-threaded* applications **cannot** be parallelized with GNU Parallel

![multi-threaded application](https://upload.wikimedia.org/wikipedia/commons/a/a5/Multithreaded_process.svg)

***

# Scripting
---

Scripts are special flat-text files that run several commands at once to process similar data in the same way

Scripts consist of two main parts
 - Header information
 - Processing bit

***

# Headers
---

```shell
#!/bin/bash

set -e
set -o pipefail
# set -u
```

***

# Shebang
---

```shell
#!/bin/bash
```

 - Tells the computer what interpreter to execute this script with
 - Only applies to executable scripts

***

# `set`
---

| Set parameter | Function |
| ------------- | -------- |
| `set -e` | Exit the script if one command fails with non-zero exit status
| `set -o pipefail` | Exit if one command in  a pipe fails |
| `set -u`* | Exit if a variable is unset |

 - *I don't use this one, instead opting to build by own checks
```shell
if [[ -z ${UNSET} ]]; then echo "Missing a variable!" >&2; exit 1; fi
```

***

# Argument passing
---

The BASH shell allows for simple argument passing to shell scripts
 - All argument passing is *positional*; there are no flags to specify which variable is which
 - Arguments have no specific type, as BASH is not an Object-Oriented Programming Language
 - Arguments are collected with a `$\<number\/\>`

```shell
arg1=$1
arg2=$2
arg3=$3
```

***

# Case Statements
---

`Case;esac` statements (also called case switches in other languages) allow for complex conditional testing, and are often used in argument parsing and creating subroutines

```shell
option=$1
case $option in
    1)
        echo "You entered '1'"
        ;;
    2)
        echo "You entered '2'"
        ;;
    3)
        echo "You entered '3'"
        ;;
    *)
        echo "Please enter a 1, 2, or 3" >&2
        ;;
esac
```
