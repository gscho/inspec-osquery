#!/bin/bash

__OSQUERY="$( command -v osqueryi 2>/dev/null )"

if [[ -e "${__OSQUERY}" ]]; then
  echo "osquery detected"
  echo "nothing to install"
else
  sudo wget https://pkg.osquery.io/deb/osquery_4.9.0-1.linux_amd64.deb
  sudo dpkg -i osquery_4.9.0-1.linux_amd64.deb
fi
