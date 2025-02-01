# Parameter Expansion

- [Parameter Expansion](#parameter-expansion)
  - [${parameter:-word}](#parameter-word)
  - [${parameter:=word}](#parameterword)
  - [${parameter:?word}](#parameterword-1)
  - [${parameter:+word}](#parameterword-2)
  - [${#parameter}](#parameter)
  - [${parameter#word}](#parameterword-3)
  - [${parameter##word}](#parameterword-4)
  - [${parameter%word}](#parameterword-5)
  - [${parameter%%word}](#parameterword-6)
  - [${parameter/pattern/string}](#parameterpatternstring)
  - [${parameter/#pattern/string}](#parameterpatternstring-1)
  - [${parameter/%pattern/string}](#parameterpatternstring-2)
  - [${parameter^}](#parameter-1)
  - [${parameter^^}](#parameter-2)
  - [${parameter,}](#parameter-3)
  - [${parameter,,}](#parameter-4)
  - [${parameter:offset}](#parameteroffset)
  - [${parameter:offset:length}](#parameteroffsetlength)
  - [${!prefix}\*](#prefix)
  - [${!name\[@\]}](#name)
  - [${parameter@operator}](#parameteroperator)

## ${parameter:-word}

If parameter is **unset or null**, use word as the default value.

```bash
# HACK: 1) ${parameter:-word}

var=""
echo ${var:-"default"}  # Output: default
```

## ${parameter:=word}

If parameter is unset or null, assign word to parameter and use it.

```bash
# HACK: 2) ${parameter:=word}

unset var
echo ${var:="default"}  # Output: default
echo $var               # Output: default
```

## ${parameter:?word}

If parameter is unset or null, print word as an error and exit.

```bash
# HACK: 3) ${parameter:?word}

unset var
echo ${var:?"Error: var is unset or null"} # Exits with error message - echo $?
```

## ${parameter:+word}

If parameter is set and not null, use word; otherwise, use nothing.

```bash
# HACK: 4) ${parameter:+word}

var="value"
echo ${var:+"alternate"}  # Output: alternate
```

## ${#parameter}

Get the length of the value of parameter.

```bash
# HACK: 5) ${#parameter}

var="hello"
echo ${#var}  # Output: 5
```

## ${parameter#word}

Remove the shortest match of word from the beginning of parameter.

```bash
# HACK: 6) ${parameter#word}

var="file.txt"
echo ${var#file}  # Output: .txt
```

## ${parameter##word}

Remove the longest match of word from the beginning of parameter.

```bash
# HACK: 7) ${parameter##word}

var="file.txt.bak"
echo ${var##*.}  # Output: bak
```

## ${parameter%word}

Remove the shortest match of word from the end of parameter.

```bash
# HACK: 8) ${parameter%word}

var="file.txt"
echo ${var%.*}  # Output: file
```

## ${parameter%%word}

Remove the longest match of word from the end of parameter.

```bash
# HACK: 9) ${parameter%%word}

var="file.txt.bak"
echo ${var%%.*}  # Output: file
```

## ${parameter/pattern/string}

Replace the first match of pattern with string.

```bash
# HACK: 10) ${parameter/pattern/string}

var="hello world"
echo ${var/hello/hi}  # Output: hi world
```

## ${parameter/#pattern/string}

Replace pattern with string only if it matches at the beginning of parameter.

```bash
# HACK: 11) ${parameter/#pattern/string}

var="hello world"
echo ${var/#hello/hi}  # Output: hi world
```

## ${parameter/%pattern/string}

Replace pattern with string only if it matches at the end of parameter.

```bash
# HACK: 12) ${parameter/%pattern/string}

var="hello world"
echo ${var/%world/earth}  # Output: hello earth
```

## ${parameter^}

Convert the first character of parameter to uppercase.

```bash
# HACK: 13) ${parameter^}

var="hello"
echo ${var^}  # Output: Hello
```

## ${parameter^^}

Convert all characters of parameter to uppercase.

```bash
# HACK: 14) ${parameter^^}

var="hello"
echo ${var^^}  # Output: HELLO
```

## ${parameter,}

Convert the first character of parameter to lowercase.

```bash
# HACK: 15) ${parameter,}

var="HELLO"
echo ${var,}  # Output: hELLO
```

## ${parameter,,}

Convert all characters of parameter to lowercase.

```bash
# HACK: 16) ${parameter,,}

var="HELLO"
echo ${var,,}  # Output: hello
```

## ${parameter:offset}

Extract a substring starting at offset.

```bash
# HACK: 17) ${parameter:offset}

var="hello world"
echo ${var:6}  # Output: world
```

## ${parameter:offset:length}

Extract a substring starting at offset with a specified length.

```bash
# HACK: 18) ${parameter:offset:length}

var="hello world"
echo ${var:6:3}       # Output: wor
echo ${var: -2}       # Output: ld
echo ${var: -2:1}     # Output: l
echo ${var: -4:-3}    # Output: o
echo ${var: -4:-2}    # Output: or
array[0]=01234567890abcdefgh
echo ${array[0]:7:2}  # 78
```

## ${!prefix}*

Expand to the names of variables with the specified prefix.

```bash
# HACK: 19) ${!prefix}*

foo1="a"
foo2="b"
echo ${!foo*}  # Output: foo1 foo2
```

## ${!name[@]}

Expand to the indices or keys of an array or associative array.

```bash
# HACK: 20) ${!name[@]}

arr=("a" "b" "c")
echo ${!arr[@]}  # Output: 0 1 2
```

## ${parameter@operator}

Apply a transformation to the value of parameter based on the operator.

```bash
# HACK: 21) ${parameter@operator}

var="hello"
echo ${var@U}  # Output: HELLO (uppercase)
echo ${var@u}  # Output: Hello (capitalize first letter)

var="HEllo"
echo ${var@L}  # Output: hello

declare -r var="Hello"
echo ${var@a}  # Output: r (read-only attribute)

var="Hello World"
echo ${var@A}  # Output: var='Hello World'

var="\u@\h"
echo ${var@P}
```
