#!/bin/bash
if ifconfig -a | grep -e 'wg-mullvad' > /dev/null; then echo 'UP'; else echo 'DOWN'; fi

