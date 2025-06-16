#!/bin/bash
set -o errexit

. /shared/functions.sh

if ! gpg --list-key | grep "$GPGID"; then
  gpgkeyimport "$GPGPUBLICKEY"
  gpgkeyimport "$GPGENCKEY_FILE" "$GPGENCPASS_FILE"
fi

unset GPGENCPASS_FILE
unset GPGENCKEY_FILE

echoc "Dystopian AUR initialisation successfull!" c=AUR g=successfull bold=AUR,successfull
exec "${@}"
