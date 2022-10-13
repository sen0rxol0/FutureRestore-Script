#!/bin/bash
clear
./futurerestore -t ./files/blob.shsh2 --latest-sep --latest-baseband $1
exit $?
