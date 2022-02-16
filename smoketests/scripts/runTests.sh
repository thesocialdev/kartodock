#!/bin/sh

set -e

pg_prove -v /etc/kartodock/smoketests/tests/*.sql

exit 0
