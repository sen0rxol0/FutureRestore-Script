#!/bin/bash
./futurerestore -t ./files/blob.shsh2 --latest-sep --latest-baseband $1
clear
exit $?

