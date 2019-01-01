#!/bin/bash
coproc acpi_listen
trap 'kill $COPROC_PID' EXIT

file_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $file_dir

while read -u "${COPROC[0]}" -a event; do
	echo got btn press
	"${file_dir}/handler_power_gui.sh" "${event[@]}"
	
done
