#!/bin/bash

# conditional_expressions_lib.sh
# v1.0.0

# Conditional Expressions Library

# Run:
#   ./deploy.sh
#   . cel
#   cel -h
#   cel -h | more
#   declare -F | grep cel


declare LIB_NAME

# Exit code for -h,--help option in the Conditional Expression LIBrary
declare LIB_TEST="conditional_expressions_lib_test.sh"
declare NON_EXPRESSION_FUNC="main|init_cel|print_help|_exit_ok|clear_args|test_all_lib"
declare -i CELIB_HELP_EXIT=128
declare ARGS
declare -A args=(["help"]="off" ["verbose"]="off" ["usage"]="off" ["list"]="off" ["clear"]="off" ["debug"]="off" ["test"]="off")
declare COMMON_OPTIONS="
          -h, --help      display option description end exit
          -v, --verbose   display detailed help end exit
          -u, --usage     display usage help end exit
          -d, --debug     activate debugging
"


function init_cel ()
{
  function clear_args ()
  {
    for arg in "${!args[@]}"; do args["$arg"]="off"; done
  }

  ARGS=("$@")

  clear_args

  for arg in "${ARGS[@]}"; do
    case $arg in
      -c|--clear)     args["clear"]="on" ;;&
      -l|--list)      args["list"]="on" ;;&
      -h|--help)      args["help"]="on" ;;&
      -v|--verbose)   args["verbose"]="on" ;;&
      -u|--usage)     args["usage"]="on" ;;&
      -d|--debug)     args["debug"]="on" ;;&
      -t|--test)      args["test"]="on" ;;
    esac
  done

  if [[ "${args["debug"]}" == "on" ]]; then    
    echo ">>> ---"
    echo ">>> Function: $(echo ${FUNCNAME[*]} | sed 's\ \ < \g')"
    echo ">>> ARGS: $(echo ${ARGS[*]})"
    for arg in "${!args[@]}"; do echo ">>> $arg: ${args[$arg]}"; done
  fi
}


function print_help ()
{
  local HELP_MSG="$1"

  [[ "${args["help"]}" == "on" ]] \
    && { echo -e "${HELP_MSG}"; return "$CELIB_HELP_EXIT"; }

  [[ "${args["usage"]}" == "on" ]] \
    && { echo -e "${HELP_MSG}" | sed -n "1p"; return "$CELIB_HELP_EXIT"; }

  [[ "${args["verbose"]}" == "on" ]] \
    && { echo -e "${HELP_MSG}" | sed -n "2,3p"; return "$CELIB_HELP_EXIT"; }
  
}


function test_all_lib ()
{
  local _continue

  if [[ "$LIB_NAME" != "-bash" ]]; then
    [[ "$0" != "-bash" ]] && source ./${LIB_TEST}

    for func_name in $(grep "function.*()" "$LIB_NAME" | grep -vE "$NON_EXPRESSION_FUNC" | cut -d' ' -f2 | grep -v "^$"); do
      eval "test_$func_name"
    
      if [ $? = 0 ] ; then echo "test_$func_name ... Ok"; else echo "test_$func_name ... Error"; fi
      echo "---"
      read -r -p "Continue (y/n): " _continue
      [ "$_continue" = "n" ] && return
    done
  fi
}


# TODO: File expressions

function cel_is_file_available ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -a file
              True if file exists.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is exists
          1   if file is not exists
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -a "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_block_file ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -b file
              True if file exists and is a block special file.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is a block file
          1   if file is not not a block file
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -b "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_character_file ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -c file
              True if file exists and is a character special file.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is a character file
          1   if file is not not a character file
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -c "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_directory ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -d file
              True if file exists and is a directory.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is a directory
          1   if file is not not a directory
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -d "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_file_exists ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -e file
              True if file exists.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file exists
          1   if file does not exist
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -e "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_regular_file ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -f file
              True if file exists and is a regular file.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is a regular file
          1   if file is not a regular file
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -f "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_set_group_id ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -g file
              True if file exists and is set-group-id.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is set-group-id
          1   if file is not set-group-id
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -g "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_symbolic_link ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -h file
              True if file exists and is a symbolic link.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is a symbolic link
          1   if file is not a symbolic link
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -h "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_sticky_bit ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -k file
              True if file exists and its 'sticky' bit is set.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file and its 'sticky' bit is set
          1   if file and its 'sticky' bit is not set
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -k "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_named_pipe ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -p file
              True if file exists and is a named pipe (FIFO).

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is a named pipe
          1   if file is not a named pipe
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -p "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_file_readable ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -r file
              True if file exists and is readable.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is readable
          1   if file is not readable
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -r "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_not_empty_file ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -s file
              True if file exists and has a size greater than zero.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is not empty
          1   if file is empty
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -s "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_fd_terminal ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE_DESCRIPTOR [OPTIONS]
    -t fd  
              True if file descriptor fd is open and refers to a terminal.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file descriptor is refers to a terminal
          1   if file descriptor is not refers to a terminal
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} 0
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -t "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_setuid_file ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -u file
              True if file exists and its set-user-id bit is set.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if user-id bit is set
          1   if user-id bit is not set
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} /bin/bash
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -u "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_writable_file ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -w file
              True if file exists and is writable.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is writable
          1   if file is not writable
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -w "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_executable_file ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -x file
              True if file exists and is executable.
    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is executable
          1   if file is not executable
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -x "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_file_owned_by_group ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -G file
              True if file exists and is owned by the effective group id.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is owned by the effective group
          1   if file is not owned by the effective group
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -G "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_symlink ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -L file
              True if file exists and is a symbolic link.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is a symbolic link
          1   if file is not a symbolic link
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -L "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_file_modified_since_last_read ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -N file
              True if file exists and has been modified since it was last read.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file has been modified since it was last read
          1   if file has not been modified since it was last read
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -N "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_file_owned_by_user ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -O file
              True if file exists and is owned by the effective user id.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file is owned by the effective user id
          1   if file is not owned by the effective user id
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -O "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_socket ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE [OPTIONS]
    -S file
              True if file exists and is a socket.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if a file exists and is a socket
          1   if a file exists and is not a socket
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -S "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_are_same_files ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE1 FILE2 [OPTIONS]
    file1 -ef file2
              True if file1 and file2 refer to the same device and inode numbers.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if files are the same
          1   if files are not the same
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file1_name file2_name
  "
  local _arg1="$1"
  local _arg2="$2"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ "$_arg1" -ef "$_arg2" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_file_newer ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE1 FILE2 [OPTIONS]
    file1 -nt file2
              True if file1 is newer (according to modification date) than file2, or if file1 exists and file2 does not.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file1 is newer then file2
          1   if file1 is older then file2
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file1_name file2_name
  "
  local _arg1="$1"
  local _arg2="$2"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ "$_arg1" -nt "$_arg2" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_file_older ()
{
  local HELP="Usage: ${FUNCNAME[0]} FILE1 FILE2 [OPTIONS]
    file1 -ot file2
              True if file1 is older than file2, or if file2 exists and file1 does not.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if file1 is older then file2
          1   if file1 is newer then file2
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} file1_name file2_name
  "
  local _arg1="$1"
  local _arg2="$2"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ "$_arg1" -ot "$_arg2" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


# TODO: Bash option expressions

function cel_is_shell_option_enabled ()
{
  local HELP="Usage: ${FUNCNAME[0]} OPTION
    -o optname
              True if the shell option optname is enabled. See the list of options under the description of the -o
              option to the set builtin below.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if bash option is enabled
          1   if bash option is not enabled
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} verbose
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -o "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


# TODO: Variable expressions

function cel_is_variable_set ()
{
  local HELP="Usage: ${FUNCNAME[0]} VARIABLE [OPTIONS]
    -v varname
              True if the shell variable varname is set (has been assigned a value).

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if a shell variable is set
          1   if a shell variable is not set
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} var_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -v "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_name_reference ()
{
  local HELP="Usage: ${FUNCNAME[0]} VARIABLE [OPTIONS]
    -R varname
              True if the shell variable varname is set and is a name reference.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if a shell variable is a name reference
          1   if a shell variable is not a name reference
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} var_name
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -R "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


# TODO: String expressions

function cel_is_string_empty ()
{
  local HELP="Usage: ${FUNCNAME[0]} STRING [OPTIONS]
    -z string
              True if the length of string is zero.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if a string is of zero length
          1   if a string is not of zero length
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} ''
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -z "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


function cel_is_string_non_empty ()
{
  local HELP="Usage: ${FUNCNAME[0]} STRING [OPTIONS]
    -n string
              True if the length of string is non-zero.

    Options:
          ${COMMON_OPTIONS}
    Exit status:
          0   if a string is not of zero length
          1   if a string is of zero length
          128 running with -h,--help option
    Example:
          ${FUNCNAME[0]} hello
  "
  local _arg1="$1"

  init_cel "$@"
  print_help "$HELP"
  
  local condition='[[ -n "$_arg1" ]]'
  [[ "${args["debug"]}" == "on" ]] && echo ">>> Condition: $condition"
  eval "$condition"
}


# Main

function main () 
{
  ARGS=("$@")
  LIB_NAME="$0"
  local HELP="
  Usage: . ${LIB_NAME[0]} [OPTIONS]
    Conditional expressions library (cel) for Bash.

    Options:
          no OPTIONS      load functions
          -h, --help      display option description end exit
          -v, --verbose   display detailed help end exit
          -d, --debug     activate debugging
          -l, --list      list all functions
          -c, --clear     remove all functions

    Exit status:
          0   the library loaded without errors
    Example:
          . ${LIB_NAME[0]}
          . ${LIB_NAME[0]} -c
          ${LIB_NAME[0]} -l
          ${LIB_NAME[0]} -h
          ${LIB_NAME[0]} -h -d
  "

  init_cel "${ARGS[@]}"
  print_help "$HELP"

  [[ "${args["clear"]}" == "on" ]] \
    && for func in $(declare -F | grep -o -E "cel\_.*|init_cel"); do unset "$func"; done

  [[ "${args["test"]}" == "on" ]] && test_all_lib "$@"

  if [[ "$LIB_NAME" != "-bash" ]]; then
    grep "function.*()" "$LIB_NAME" | grep -vE "$NON_EXPRESSION_FUNC" | cut -d' ' -f2 | grep -v "^$" | \
      while read -r func_name; do
        [[ "${args["debug"]}" == "on" ]] && echo ">>> $func_name"

        [[ "${args["list"]}" == "on" ]] && echo "$func_name"

        [[ "${args["help"]}" == "on" ]] && eval "$func_name ${ARGS[*]}"
        
        [[ "${args["usage"]}" == "on" ]] && eval "$func_name ${ARGS[*]}"

        [[ "${args["verbose"]}" == "on" ]] && eval "$func_name ${ARGS[*]}"
      done
  fi
}


function _exit_ok () { :; }

(( "$#" > 0 )) && main "$@" || _exit_ok
