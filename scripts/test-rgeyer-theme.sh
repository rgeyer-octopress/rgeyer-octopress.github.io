#!/bin/sh

rake install["rgeyer"] < scripts/installanswers.txt
rake generate
