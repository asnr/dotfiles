#! /bin/sh

set -e

DOTFILES_DIR=$(pwd)

echo Linking files from link/ into $HOME
echo

LINK_DIR=link

for file_to_link in $(find $LINK_DIR -type f); do
  SOURCE_PATH=$DOTFILES_DIR/$file_to_link
  LINK_TO_CREATE=$HOME/${file_to_link#$LINK_DIR/}
  echo SOURCE_PATH $SOURCE_PATH
  echo LINK_TO_CREATE $LINK_TO_CREATE
  ln -s $SOURCE_PATH $LINK_TO_CREATE
done

echo
echo DONE
