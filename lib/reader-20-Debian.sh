#!/bin/bash
# Copyright Roche Sequencing Solutions inc. and Daniel Alder

# Description:
#   fuzzy search for known licence names

set -e

package="$1"
copyrightfile=
if [ -f "/usr/share/doc/$package/copyright" ]; then
  copyrightfile="/usr/share/doc/$package/copyright"
elif [ -f "/usr/share/doc/${package%:*}/copyright" ]; then
  copyrightfile="/usr/share/doc/${package%:*}/copyright"
else
  exit 0  # no copyright file found
fi

result=$(grep 'in the Debian Distribution' \
    "$copyrightfile" | sed -r -e 's/[Ll]icence/License/g' | sort -u)
if [ -n "$result" ]; then
  echo "Debian"
fi

exit 0

