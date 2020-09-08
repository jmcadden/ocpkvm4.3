#!/bin/bash

_NAME=${1}
_NET=${2}
_DISK=${3}
_PATH=${4}

virt-install --name="ocp4-${_NAME}" --vcpus=4 --ram=16384 \
--disk path="${_PATH}"/ocp4-${_NAME}.qcow2,bus=virtio,size=150 \
--os-variant rhel8.0 --network network="${_NET}",model=e1000 \
--boot menu=off --print-xml > ocp4-${_NAME}.xml

_DISK_L=$(cat ocp4-${_NAME}.xml | grep -n ${_DISK} | cut -d ':' -f 1)
_DISK_L=$((_DISK_L+1))
sed -i -e "${_DISK_L}i\      <boot order='1'/>" ocp4-${_NAME}.xml
_NIC_L=$(cat ocp4-${_NAME}.xml | grep -n ${_NET} | cut -d ':' -f 1)
_NIC_L=$((_NIC_L+3))
sed -i -e "${_NIC_L}i\      <boot order='2'/>" ocp4-${_NAME}.xml
sed -i '/boot dev/d' ocp4-${_NAME}.xml
virsh define --file ocp4-${_NAME}.xml
