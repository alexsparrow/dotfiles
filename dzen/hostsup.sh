#!/bin/zsh

HOSTS=('alspar.dyndns.org' 'alspar.tilaa.org' 'lxplus.cern.ch' 'lx06.hep.ph.ic.ac.uk')

ping() {
    local i;
    for i in $HOSTS
    {
	print -n '^fg(khaki)' $i '^fg()': $(~/.alexdot/dzen/ping.sh $i)' '
    }
}

while true; do
    PINGS=$(ping)
    print "$PINGS"
    sleep 60;
done
