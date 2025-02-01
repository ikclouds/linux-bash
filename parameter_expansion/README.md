# Parameter Expansion

- [Parameter Expansion](#parameter-expansion)
  - [${parameter:-word}](#parameter-word)
  - [${parameter-word}](#parameter-word-1)
  - [${parameter:=word}](#parameterword)
  - [${parameter=word}](#parameterword-1)
  - [${parameter:?word}](#parameterword-2)
  - [${parameter?word}](#parameterword-3)
  - [${parameter:+word}](#parameterword-4)
  - [${parameter+word}](#parameterword-5)

## ${parameter:-word}

If parameter is **unset or null**, use word as the default value.

```bash
# HACK: 1) ${parameter:-word}

var=""
echo ${var:-"default"}  # Output: default
```

## ${parameter-word}

If parameter is **unset (but not null)**, use word as the default value.

```bash
# HACK: 2) ${parameter-word}

unset var
echo ${var-"default"}  # Output: default
```

## ${parameter:=word}

If parameter is unset or null, assign word to parameter and use it.

```bash
# HACK: 3) ${parameter:=word}

unset var
echo ${var:="default"}  # Output: default
echo $var               # Output: default
```

## ${parameter=word}

If parameter is unset (but not null), assign word to parameter and use it.

```bash
# HACK: 4) ${parameter=word}

unset var
echo ${var="default"}  # Output: default
echo $var              # Output: default
```

## ${parameter:?word}

If parameter is unset or null, print word as an error and exit.

```bash
# HACK: 5) ${parameter:?word}

unset var
echo ${var:?"Error: var is unset or null"} # Exits with error message - echo $?
```

## ${parameter?word}

If parameter is unset (but not null), print word as an error and exit.

```bash
# HACK: 6) ${parameter?word}

unset var
echo ${var?"Error: var is unset"}  # Exits with error message
```

## ${parameter:+word}

If parameter is set and not null, use word; otherwise, use nothing.

```bash
# HACK: 7) ${parameter:+word}

var="value"
echo ${var:+"alternate"}  # Output: alternate
```

## ${parameter+word}

If parameter is set (even if null), use word; otherwise, use nothing.

```bash
# HACK: ${parameter+word}

var=""
echo ${var+"alternate"}  # Output: alternate
```
