#!/bin/bash

for file in `ls *.ly`; do
        convert-ly $file > $file.2 && mv $file.2 $file
done