#!/bin/bash

echo "Enter butane filename to convert"

#Convert butane file to ignition file

read bufile

podman run --rm --tty --interactive --security-opt label=disable --volume ${PWD}:/pwd --workdir /pwd quay.io/coreos/butane:release --pretty --strict $bufile --output ignition_out.ign

#Validate ignition file

podman run --rm --tty --interactive --security-opt label=disable --volume ${PWD}:/pwd --workdir /pwd quay.io/coreos/ignition-validate:release ignition_out.ign && echo 'Congrats!! Ignition file validated.'

#convert ignition file to iso

echo "Enter ignition filename to convert"

podman run --rm --tty --interactive --security-opt label=disable --volume ${PWD}:/pwd --workdir /pwd quay.io/coreos/coreos-installer:release iso ignition embed fedora-coreos.iso --ignition-file ignition_out.ign --output custom_fcos.iso


echo "ISO file created!!"
