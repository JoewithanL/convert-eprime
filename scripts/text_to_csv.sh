#!/usr/bin/env bash

## E-PRIME TEXT_TO_CSV SCRIPT:
# Runs the convert.py script used to convert E-Prime txt files to csv files.
#   - Specify base directory, and list all subject IDs.
#   - Assumes the following directory structure: /BASEDIR/sourcedata/sub-SUB/beh/
#   - naming_config.txt used to specify the user specified naming changes
#
# 2020/02/26 - Joel P. Diaz, itsjoewithanl@gmail.com

############### USER INPUT ##################
SUB=(01 02 03 04 05)
BASEDIR="/Volumes/data"

############### END PARAMETERS ##############
COMMAND="python ../convert_eprime/convert.py text_to_csv" # the command that will be executed

for ((  i = 0 ;  i <= ${#SUB[@]}-1;  i++  ))  # loops through subjects
do
	SUBNAME=${SUB[i]}
	FILEPATH=${BASEDIR}/sourcedata/sub-"${SUBNAME}"/beh

  # read naming_config file to search for and create files based on user input
  while IFS=$'  ' read -r input output; do

    # specifies the path and the name of the file to be created
    OUTPATH=${FILEPATH}/sub-${SUBNAME}${output}.csv

    # search for txt files in sub folder and run command
    # also exports command output to rename.txt file for log tracking
    find "${FILEPATH}" -type f -name "*${input}*.txt" \
      -exec printf "${COMMAND} {} \n" >> ${FILEPATH}/rename.txt \; \
      -exec ${COMMAND} {} ${OUTPATH} ";"

  done < naming_config.txt

done
