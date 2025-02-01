# Parameter Expansion

- [Parameter Expansion](#parameter-expansion)
  - [${parameter:-word}](#parameter-word)
  - [${parameter:=word}](#parameterword)
  - [${parameter:?word}](#parameterword-1)
  - [${parameter:+word}](#parameterword-2)

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
