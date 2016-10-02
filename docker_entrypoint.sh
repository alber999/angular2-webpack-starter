#!/bin/bash

##################################################
# CONFIGURATION
##################################################
LOG_DEST_PATH=/var/log/savethecode
LOG_DEST_FILE=$LOG_DEST_PATH/angular2.log

##################################################
# DEPLOY APPLICATION
##################################################
mkdir -p $LOG_DEST_PATH

echo "Starting SaveTheCode angular2 webpack starter... be patient :)" >> $LOG_DEST_FILE
npm i >> $LOG_DEST_FILE
npm start >> $LOG_DEST_FILE

# keep running
tail -f /dev/null