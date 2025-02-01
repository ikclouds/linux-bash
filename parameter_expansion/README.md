# Parameter Expansion

- [Parameter Expansion](#parameter-expansion)
  - [${parameter:-word}](#parameter-word)

## ${parameter:-word}

If parameter is **unset or null**, use word as the default value.

```bash
# HACK: 1) ${parameter:-word}

var=""
echo ${var:-"default"}  # Output: default
```
