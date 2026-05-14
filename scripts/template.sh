#!/bin/sh
set -eu

if [ "${DEBUG:-0}" = "1" ]; then
	set -x
fi