#!/bin/bash

raspivid -t 0 -w 1280 -h 720 -hf -ih -fps 60 -o - | nc -k -l 2222
