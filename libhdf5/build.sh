#!/bin/bash

./configure  --prefix=$PREFIX
make -j 8
make install

