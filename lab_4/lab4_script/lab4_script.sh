#!/bin/bash
# Authors : Kai Schuyler Gonzalez
# Date: 09/18/2020

cp /var/log/syslog .
grep -e 'ERROR\|Error\|error' syslog | tee error_log_check.txt
sendmail kai.schuyler@gmail.com < error_log_check.txt
