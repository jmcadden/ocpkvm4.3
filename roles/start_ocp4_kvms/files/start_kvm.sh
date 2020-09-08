#!/bin/bash

_NAME=${1}
_NET=${2}
_DISK=${3}
_PATH=${4}

virsh start ocp4-${_NAME} &
#sleep for PXE boot 
sleep 60
