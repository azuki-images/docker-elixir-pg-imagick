#!/bin/sh
set -e

if [ -d "/.ssh" ]; then
	mkdir -p ~/.ssh
	cp -Rf /.ssh ~/
fi

exec "$@"
