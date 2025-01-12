#!/bin/bash

# conditional_expressions_lib_test.sh
# v1.0.0

# Tests for Conditional Expressions Library

# Run:
#   ./deploy.sh
#   celt -ut
#   ./conditional_expressions_lib.sh -ut

# Load Conditional Expressions Library
# shellcheck source=/dev/null
[[ "$1" = "-ut" ]] && source ./conditional_expressions_lib.sh

set -eE

trap 'error_handler' ERR

function error_handler () { return 1; }


# Run tests

# Test cel_is_file_available
function test_cel_is_file_available ()
{
  echo "---"
  cel_is_file_available -u | grep "Usage: cel_is_file_available"

  [ -f test_file ] && rm test_file

  cel_is_file_available test_file && echo "test_file is available" || echo "test_file is non available"

  touch test_file
  cel_is_file_available test_file && echo "test_file is available" || echo "test_file is non available"

  rm -f test_file
}

# test_cel_is_file_available


# Test cel_is_block_file
function test_cel_is_block_file ()
{
  echo "---"
  cel_is_block_file -u | grep "Usage: cel_is_block_file"

  [ -f test_file ] && rm test_file

  cel_is_block_file /dev/sda && echo "/dev/sda is block file" || echo "/dev/sda is not block file"

  touch test_file
  cel_is_block_file test_file && echo "test_file is block file" || echo "test_file is not block file"
  
  rm -f test_file
}

# test_cel_is_block_file


# Test cel_is_character_file
function test_cel_is_character_file ()
{
  echo "---"
  cel_is_character_file -u | grep "Usage: cel_is_character_file"

  [ -f test_file ] && rm test_file

  cel_is_character_file /dev/console && echo "/dev/console is character file" || echo "/dev/console is not character file"
  cel_is_character_file /dev/null && echo "/dev/null is character file" || echo "/dev/null is not character file"

  touch test_file
  cel_is_character_file test_file && echo "test_file is character file" || echo "test_file is not character file"

  rm -f test_file
}

# test_cel_is_character_file


# Test cel_is_directory
function test_cel_is_directory ()
{
  echo "---"
  cel_is_directory -u | grep "Usage: cel_is_directory"

  [ -f test_file ] && rm test_file

  cel_is_directory ./ && echo "./ is directory" || echo "test_file is not directory"

  touch test_file
  cel_is_directory test_file && echo "test_file is directory" || echo "test_file is not directory"

  rm -f test_file
}

# test_cel_is_directory


# Test cel_is_file_exists
function test_cel_is_file_exists ()
{
  echo "---"
  cel_is_file_exists -u | grep "Usage: cel_is_file_exists"

  [ -f test_file ] && rm test_file

  cel_is_file_exists test_file && echo "test_file exists" || echo "test_file does not exist"
  
  touch test_file
  cel_is_file_exists test_file && echo "test_file exists" || echo "test_file does not exist"

  rm -f test_file
}

# test_cel_is_file_exists


# Test cel_is_regular_file
function test_cel_is_regular_file ()
{
  echo "---"
  cel_is_regular_file -u | grep "Usage: cel_is_regular_file"

  [ -f test_file ] && rm test_file

  cel_is_regular_file /dev/null && echo "/dev/null is regular file" || echo "/dev/null is not regular file"

  cel_is_regular_file /dev/sda && echo "/dev/sda is regular file" || echo "/dev/sda is not regular file"

  touch test_file
  cel_is_regular_file test_file && echo "test_file is regular file" || echo "test_file is not regular file"

  rm -f test_file
}

# test_cel_is_regular_file


# Test cel_is_set_group_id
function test_cel_is_set_group_id ()
{
  echo "---"
  cel_is_set_group_id -u | grep "Usage: cel_is_set_group_id"

  [ -f test_file ] && rm test_file

  touch test_file
  cel_is_set_group_id test_file && echo "test_file is set group id" || echo "test_file is not set group id"
  rm -f test_file

  touch test_file_with_S
  chmod g+s test_file_with_S
  cel_is_set_group_id test_file_with_S && echo "test_file_with_S is set group id" || echo "test_file_with_S is not set group id"
  rm -f test_file_with_S
}

# test_cel_is_set_group_id


# Test cel_is_symbolic_link
function test_cel_is_symbolic_link ()
{
  echo "---"
  cel_is_symbolic_link -u | grep "Usage: cel_is_symbolic_link"


  ln -s /etc/passwd ~/symlink_to_passwd
  cel_is_symbolic_link ~/symlink_to_passwd && echo "symlink_to_passwd" || echo "symlink_to_passwd is simple file"
  rm -f ~/symlink_to_passwd

  [ -f ~/symlink_to_passwd ] && rm ~/symlink_to_passwd
  touch ~/symlink_to_passwd
  cel_is_symbolic_link ~/symlink_to_passwd && echo "symlink_to_passwd" || echo "symlink_to_passwd is simple file"
  rm -f ~/symlink_to_passwd
}

# test_cel_is_symbolic_link


# Test cel_is_sticky_bit
function test_cel_is_sticky_bit ()
{
  echo "---"
  cel_is_sticky_bit -u | grep "Usage: cel_is_sticky_bit"

  test_dir="test_dir"

  [ -d ~/"$test_dir" ] && rm -fr ~/"$test_dir"

  mkdir ~/"$test_dir"
  chmod +t ~/"$test_dir"
  cel_is_sticky_bit ~/"$test_dir" && echo "test_dir has the sticky bit set" || echo "test_dir does NOT have the sticky bit set"
  rm -fr ~/"$test_dir"

  chmod -t ~/"$test_dir"
  cel_is_sticky_bit ~/"$test_dir" && echo "test_dir has the sticky bit set" || echo "test_dir does NOT have the sticky bit set"
  rm -fr ~/"$test_dir"
}

# test_cel_is_sticky_bit


# Test cel_is_named_pipe
function test_cel_is_named_pipe ()
{
  echo "---"
  cel_is_named_pipe -u | grep "Usage: cel_is_named_pipe"

  [ -f test_pipe ] && rm ~/test_pipe
  [ -f test_file ] && rm ~/test_file
  
  mkfifo ~/test_pipe
  # echo "Hi" >  ~/test_pipe &
  # cat ~/test_pipe
  cel_is_named_pipe ~/test_pipe && echo "test_pipe is pipe" || echo "test_pipe is not pipe"
  rm -f test_pipe

  touch ~/test_file
  cel_is_named_pipe ~/test_file && echo "test_file is pipe" || echo "test_file is not pipe"
  rm -f ~/test_file
}

# test_cel_is_named_pipe


# Test cel_is_file_readable
function test_cel_is_file_readable ()
{
  echo "---"
  cel_is_file_readable -u | grep "Usage: cel_is_file_readable"

  [ -f test_file ] && rm ~/test_file

  touch ~/test_file
  chmod a-r ~/test_file
  cel_is_file_readable ~/test_file && echo "test_file is readable" || echo "test_file is not readable"

  chmod a+r ~/test_file
  cel_is_file_readable ~/test_file && echo "test_file is readable" || echo "test_file is not readable"
  rm -f ~/test_file
}

# test_cel_is_file_readable


# Test cel_is_not_empty_file
function test_cel_is_not_empty_file ()
{
  echo "---"
  cel_is_not_empty_file -u | grep "Usage: cel_is_not_empty_file"

  [ -f test_file ] && rm test_file

  touch test_file
  cel_is_not_empty_file test_file && echo "not empty" || echo "empty"

  echo "1" > test_file
  cel_is_not_empty_file test_file && echo "not empty" || echo "empty"

  rm -f test_file
}

# test_cel_is_not_empty_file


# Test cel_is_fd_terminal
function test_cel_is_fd_terminal ()
{
  echo "---"
  cel_is_fd_terminal -u | grep "Usage: cel_is_fd_terminal"

  cel_is_fd_terminal 0 && echo "terminal" || echo "no terminal"
  cel_is_fd_terminal 22 && echo "terminal" || echo "no terminal"
}

# test_cel_is_fd_terminal


# Test cel_is_setuid_file
function test_cel_is_setuid_file ()
{
  # ls -l /usr/bin/passwd
  # -rwsr-xr-x 1 root root 59976 Feb  6  2024 /usr/bin/passwd

  echo "---"
  cel_is_setuid_file -u | grep "Usage: cel_is_setuid_file"

  test_file="test_suid_file"

  [ -f ~/"$test_file" ] && rm ~/"$test_file"
  touch ~/"$test_file"

  chmod u+s ~/"$test_file"
  cel_is_setuid_file ~/"$test_file" && echo "setuid" || echo "no setuid"

  chmod u-s ~/"$test_file"
  cel_is_setuid_file ~/"$test_file" && echo "setuid" || echo "no setuid"

  [ -f ~/"$test_file" ] && rm ~/"$test_file"
}

# test_cel_is_setuid_file


# Test cel_is_writable_file
function test_cel_is_writable_file ()
{
  echo "---"
  cel_is_writable_file -u | grep "Usage: cel_is_writable_file"

  sudo chmod a-w ./conditional_expressions_lib.sh
  cel_is_writable_file ./conditional_expressions_lib.sh && echo "writable" || echo "not writable"

  sudo chmod u+w ./conditional_expressions_lib.sh
  cel_is_writable_file ./conditional_expressions_lib.sh && echo "writable" || echo "not writable"
}

# test_cel_is_writable_file


# Test cel_is_executable_file
function test_cel_is_executable_file ()
{
  echo "---"
  cel_is_executable_file -u | grep "Usage: cel_is_executable_file"

  sudo chmod a-x ./conditional_expressions_lib.sh
  cel_is_executable_file ./conditional_expressions_lib.sh && echo "executable" || echo "not executable"

  sudo chmod u+x ./conditional_expressions_lib.sh
  cel_is_executable_file ./conditional_expressions_lib.sh && echo "executable" || echo "not executable"
}

# test_cel_is_executable_file


# Test cel_is_file_owned_by_group
function test_cel_is_file_owned_by_group ()
{
  echo "---"
  cel_is_file_owned_by_group -u | grep "Usage: cel_is_file_owned_by_group"

  [ ! "$(getent group my_group)" ] && sudo groupadd my_group

  [ ! -d ~/my_group ] && mkdir ~/my_group
  sudo chown :my_group ~/my_group
  sudo chmod g+s ~/my_group
  touch ~/my_group/my_file
  cel_is_file_owned_by_group ~/my_group/my_file && echo "owned" || echo "not owned"

  [ ! -d ~/my_group2 ] && mkdir ~/my_group2
  sudo chown :my_group ~/my_group2
  touch ~/my_group2/my_file
  cel_is_file_owned_by_group ~/my_group2/my_file && echo "owned" || echo "not owned"

  rm -fr ~/my_group ~/my_group2
}

# test_cel_is_file_owned_by_group


# Test cel_is_symlink
function test_cel_is_symlink ()
{
  echo "---"
  cel_is_symlink -u | grep "Usage: cel_is_symlink"

  [ -f ~/my_file ] && rm ~/my_file
  touch ~/my_file
  cel_is_symlink ~/my_file && echo "link" || echo "not link"

  [ -f ~/my_link ] && rm ~/my_link
  ln -s ~/my_file ~/my_link
  cel_is_symlink ~/my_link && echo "link" || echo "not link"

  rm -f ~/my_file ~/my_link
}

# test_cel_is_symlink


# Test cel_is_file_modified_since_last_read
function test_cel_is_file_modified_since_last_read ()
{
  RED="\x1B[31m"
  NC="\x1B[37m"   # No Color

  # mtime — updated when the file contents change. This is the "default" file time in most cases.
  # ctime — updated when the file or its metadata (owner, permissions) change
  # atime — updated when the file is read
  # btime (birth) — this is explicitly a "file creation timestamp"

  # ls -lt --time atime ~/
  # ls -lt --time birth ~/

  echo "---"
  cel_is_file_modified_since_last_read -u | grep "Usage: cel_is_file_modified_since_last_read"

  [ -f ~/my_file ] && rm ~/my_file
  touch ~/my_file
  cat ~/my_file > /dev/null
  cel_is_file_modified_since_last_read ~/my_file \
    && printf "%b-->> modified" "${RED}" \
    || printf "%b-->> not modified" "${RED}"
  printf "%b\n" "${NC}"
  stat ~/my_file

  sleep 2

  echo "modified" > ~/my_file
  cel_is_file_modified_since_last_read ~/my_file \
    && printf "%b-->> modified" "${RED}" \
    || printf "%b-->> not modified" "${RED}"
  printf "%b\n" "${NC}"
  stat ~/my_file

  rm -f ~/my_file
}

# test_cel_is_file_modified_since_last_read


# Test cel_is_file_owned_by_user
function test_cel_file_is_owned_by_user ()
{
  echo "---"
  cel_is_file_owned_by_user -u | grep "Usage: cel_is_file_owned_by_user"

  [ -f ~/my_file ] && rm ~/my_file
  touch ~/my_file
  cel_is_file_owned_by_user ~/my_file && echo "owned" || echo "not owned"

  cel_is_file_owned_by_user /bin/bash && echo "owned" || echo "not owned"

  rm -f ~/my_file
}

# test_cel_file_is_owned_by_user


# Test cel_is_socket
function test_cel_is_socket ()
{
  # Internet domain sockets and Unix domain sockets.
  # Unix domain sockets: 
  #   - stream (connection-oriented) socket interfaces
  #   - datagram (connectionless) socket interfaces
  # https://www.baeldung.com/linux/unix-domain-socket-create

  echo "---"
  cel_is_socket -u | grep "Usage: cel_is_socket"

  # run 2nd WSL session
  # nc -lU /tmp/my.sock

  nc -lU /tmp/my.sock &

  # run 3nd WSL session and create Unix domain stram socket
  # nc -U /tmp/my.sock

  cel_is_socket /tmp/my.sock && echo "socket" || echo "not socket"

  cel_is_socket /bin/bash && echo "socket" || echo "not socket"

  # run in 1st WSL
  file /tmp/my.sock
  jobs
  ss -xa | grep my.sock
  pgrep nc
  pkill nc
  [ -f /tmp/my.sock ] && unlink /tmp/my.sock
  jobs -p | xargs -I{} sudo kill -9 {}
}

# test_cel_is_socket


# Test cel_are_same_files
function test_cel_are_same_files()
{
  echo "---"
  cel_are_same_files -u | grep "Usage: cel_are_same_files"

  [ -f ~/my_file ] && rm ~/my_file
  touch ~/my_file

  [ -f ~/my_link_soft ] && rm ~/my_link_soft
  ln -s ~/my_file ~/my_link_soft
  cel_are_same_files ~/my_file ~/my_link_soft && echo "soft same" || echo "soft not same"

  [ -f ~/my_link_hard ] && rm ~/my_link_hard
  ln ~/my_file ~/my_link_hard
  cel_are_same_files ~/my_file ~/my_link_hard && echo "hard same" || echo "hard not same"

  cel_are_same_files /bin/bash ~/my_link_soft && echo "soft same" || echo "soft not same"
  cel_are_same_files /bin/bash ~/my_link_hard && echo "hard same" || echo "hard not same"

  rm -f ~/my_file ~/my_link_soft ~/my_link_hard
}

# test_cel_are_same_files


# Test cel_is_file_newer
function test_cel_is_file_newer()
{
  echo "---"
  cel_is_file_newer -u | grep "Usage: cel_is_file_newer"

  [ -f ~/my_file1 ] && rm ~/my_file1
  touch ~/my_file1

  [ -f ~/my_file2 ] && rm ~/my_file2
  touch ~/my_file2

  cel_is_file_newer ~/my_file1 ~/my_file2 && echo "newer" || echo "older"

  rm -f ~/my_file1 ~/my_file2
}

# test_cel_is_file_newer


# Test cel_is_file_older
function test_cel_is_file_older()
{
  echo "---"
  cel_is_file_older -u | grep "Usage: cel_is_file_older"

  [ -f ~/my_file1 ] && rm ~/my_file1
  touch ~/my_file1

  [ -f ~/my_file2 ] && rm ~/my_file2
  touch ~/my_file2

  cel_is_file_older ~/my_file1 ~/my_file2 && echo "newer" || echo "older"

  rm -f ~/my_file1 ~/my_file2
}

# test_cel_is_file_older


# Test cel_is_shell_option_enabled
function test_cel_is_shell_option_enabled()
{
  echo "---"
  cel_is_shell_option_enabled -u | grep "Usage: cel_is_shell_option_enabled"

  # set -v
  set -o | grep -Eo "\w*" | grep -vE "on|off" | \
  while read -r opt; do
    cel_is_shell_option_enabled "$opt" && opt_value="on" || opt_value="off"
    echo "$opt: $opt_value"
  done

  set -o verbose - > /dev/null
  echo --
  set -o | grep verbose
}

# test_cel_is_shell_option_enabled


# Test cel_is_variable_set
function test_cel_is_variable_set()
{
  echo "---"
  cel_is_variable_set -u | grep "Usage: cel_is_variable_set"

  cel_is_variable_set not_declared_variable1 && echo "set" || echo "not set"

  declare -i declared_variable2
  cel_is_variable_set declared_variable2 && echo "set" || echo "not set"
  
  declare declared_variable3=""
  cel_is_variable_set declared_variable3 && echo "set" || echo "not set"

  declared_variable4="a"
  cel_is_variable_set declared_variable4 && echo "set" || echo "not set"

}

# test_cel_is_variable_set


# Test cel_is_name_reference
function test_cel_is_name_reference()
{
  echo "---"
  cel_is_name_reference -u | grep "Usage: cel_is_name_reference"

  declare var="value"
  declare -n var_reference="var"
  echo "$var_reference"

  cel_is_name_reference var && echo "reference" || echo "not reference"
  cel_is_name_reference var_reference && echo "reference" || echo "not reference"
}

# test_cel_is_name_reference


# Test cel_is_string_empty
function test_cel_is_string_empty()
{
  echo "---"
  cel_is_string_empty -u | grep "Usage: cel_is_string_empty";

  cel_is_string_empty "" && echo "empty" || echo "not empty"
  cel_is_string_empty "Hi!" && echo "empty" || echo "not empty"
}

# test_cel_is_string_empty


# Test cel_is_string_non_empty
function test_cel_is_string_non_empty()
{
  echo "---"
  cel_is_string_non_empty -u | grep "Usage: cel_is_string_non_empty"

  cel_is_string_non_empty "Hi!" && echo "not empty" || echo "empty"
  cel_is_string_non_empty "" && echo "not empty" || echo "empty"
}

# test_cel_is_string_non_empty
