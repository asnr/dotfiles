#! /bin/sh

set -eu

DOTFILES_DIR=$PWD

echo Linking files from link/ into $HOME
echo

LINK_DIR=link

find $LINK_DIR ! -name '*~' ! -name '*.swp' -type f | while read file_to_link
do
  SOURCE_PATH="$DOTFILES_DIR/$file_to_link"
  LINK_SUFFIX="${file_to_link#$LINK_DIR/}"
  LINK_TO_CREATE="$HOME/$LINK_SUFFIX"
  PRETTY_LINK_TO_CREATE="~/$LINK_SUFFIX"

  # If symlink already exists, do nothing. If file exists, back it up
  # else create link
  if test "$SOURCE_PATH" -ef "$LINK_TO_CREATE"; then
    echo "Link to $file_to_link already exists, moving on"
  elif test ! -e "$LINK_TO_CREATE"; then
    echo "Creating link $PRETTY_LINK_TO_CREATE -> $file_to_link"
    if test ! -d "$(dirname "$LINK_TO_CREATE")"; then
      mkdir -p "$(dirname "$LINK_TO_CREATE")"
    fi
    ln -s "$SOURCE_PATH" "$LINK_TO_CREATE"
  else
    echo "$PRETTY_LINK_TO_CREATE already exists but is not a symlink to $SOURCE_PATH"
    echo "Aborting"
    exit 1
  fi
done

echo
echo Compiling custom less keybindings to $HOME/.less
lesskey -o $HOME/.less $HOME/.less.source

echo
echo "Done"
