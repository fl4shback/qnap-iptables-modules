#!/usr/bin/env bash

. build_env.sh


IP6TABLES_MODULES_DIR="$KERNEL_DIR/net/ipv6/netfilter"


function build() {
    pushd "$KERNEL_DIR"

    # apply the kernel configuration
    make olddefconfig

    # prepare building
    make scripts
    make prepare
    make modules_prepare

    # build only the ip6tables_nat module
    make -C . M=net/ipv6/netfilter

    popd
}


function collect_artifacts() {
    cp "$IP6TABLES_MODULES_DIR/ip6t_NPT.ko" "$OUT_DIR/"
    cp "$IP6TABLES_MODULES_DIR/ip6t_REJECT.ko" "$OUT_DIR/"
    cp "$IP6TABLES_MODULES_DIR/nf_reject_ipv6.ko" "$OUT_DIR/"
    cp "$IP6TABLES_MODULES_DIR/ip6table_nat.ko" "$OUT_DIR/"
}


entry_point "$@"
