#!/usr/bin/env python

import graphitesend
import time
import os

graphitesend.init(graphite_server='graphite.cloud.nibalizer.com')

while True:

    with open('/sys/class/power_supply/BAT0/energy_now') as f:
      lines = f.read()
    f.closed
    energy_now = float(lines)
    with open('/sys/class/power_supply/BAT0/energy_full') as f:
      lines = f.read()
    f.closed
    energy_full = float(lines)
    batt_percent = energy_now/energy_full * 100



    load = os.getloadavg()[0]
    graphitesend.send('battery_percent', batt_percent)
    graphitesend.send('load', load)
    print "batt_percent: %s" % batt_percent
    time.sleep(1)

