#; -*-sh-*-

function current_keyboard_layout() {
  defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID | \
    sed 's:.*\.\([[:alpha:]]*\)$:\1:'
}

function next_keyboard_layout() {
  # Simulate pressing Ctrl+Opt+Space
  # This is very brittle, should try and find a more semantic approach
  osascript -e 'tell application "System Events"' \
            -e 'keystroke space using {control down, option down}' \
            -e 'end tell'
}

function qwerty() {
  if test "$(current_keyboard_layout)" != Australian; then
    next_keyboard_layout
  fi
}

function colemak() {
  if test "$(current_keyboard_layout)" != Colemak; then
    next_keyboard_layout
  fi
}

function mkcd() {
  mkdir $1
  cd $1
}
