#!/bin/bash

# Define a timestamp function
timestamp() {
  date +"%T"
}

# do something...
timestamp # print timestamp
# do something else...
sleep 2
timestamp # print another timestamp
# continue..
