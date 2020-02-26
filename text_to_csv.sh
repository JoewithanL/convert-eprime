#!/usr/bin/env bash

## E-PRIME TEXT_TO_CSV SCRIPT:
# Runs the convert.py script used to convert E-Prime txt files to csv files.
#   - Specify base directory, and list all subject IDs.
#   - Assumes the following directory structure: /BASEDIR/sourcedata/sub-SUB/beh/

########## USER INPUT #############
SUB=(01 02 03 04 05)
BASEDIR="/Volumes/data/"

########## END PARAMETERS #########
COMMAND="python ./convert_eprime/convert.py text_to_csv"

for ((  i = 0 ;  i <= ${#SUB[@]}-1;  i++  ))
do
	SUBNAME=${SUB[i]}

  # search for txt files in sub folder and run command
  find ${BASEDIR}/sourcedata/sub-"${SUBNAME}"/beh -type f -name "*.txt" -exec ${COMMAND} {} {}.csv ";"

done
