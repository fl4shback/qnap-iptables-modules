#!/usr/bin/env bash

. build_env.sh


IPTABLES_MODULES_DIR="$KERNEL_DIR/net/ipv4/netfilter"


function build() {
    pushd "$KERNEL_DIR"

    # apply the kernel configuration
    make olddefconfig

    # prepare building
    make scripts
    make prepare
    make modules_prepare

    # build only the iptables module
    make -C . M=net/ipv4/netfilter

    popd
}


function collect_artifacts() {
    cp "$IPTABLES_MODULES_DIR/iptable_mangle.ko" "$OUT_DIR/"
    cp "$IPTABLES_MODULES_DIR/iptable_raw.ko" "$OUT_DIR/"
}


entry_point "$@"
