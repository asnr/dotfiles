#! /bin/sh

set -eu

DOTFILES_DIR=$PWD

echo Linking files from link/ into $HOME
echo

LINK_DIR=link

for file_to_link in $(find $LINK_DIR ! -name '*~' ! -name '*.swp' -type f); do
  SOURCE_PATH=$DOTFILES_DIR/$file_to_link
  LINK_TO_CREATE=$HOME/${file_to_link#$LINK_DIR/}

  # If symlink already exists, do nothing. If file exists, back it up
  # else create link
  if test $SOURCE_PATH -ef $LINK_TO_CREATE; then
    echo Link to $SOURCE_PATH already exists, moving on
  elif test ! -e $LINK_TO_CREATE; then
    echo Creating a link at $LINK_TO_CREATE pointing to $SOURCE_PATH
    ln -s $SOURCE_PATH $LINK_TO_CREATE
  else
    echo $LINK_TO_CREATE already exists but is not a symlink to $SOURCE_PATH
    echo Aborting
    exit 1
  fi
done

echo
echo Done
