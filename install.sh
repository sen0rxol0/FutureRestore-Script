#!/bin/bash
./futurerestore -t blob.shsh2 --latest-sep --latest-baseband $1
clear
exit $?

