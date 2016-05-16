======================
Salt Logrotate Formula
======================

Logrotate is designed to ease administration of systems that generate
large numbers of log files. It allows automatic rotation, compression,
removal, and mailing of log files. Each log file may be handled daily,
weekly, monthly, or when it grows too large.

Example pillar
==============

Configuration for syslog from Ubuntu 14.04 (trusty):

.. code-block:: yaml

    logrotate:
      server:
        enabled: true
        job:
          rsyslog:
            - files:
              - /var/log/mail.info
              - /var/log/mail.warn
              - /var/log/mail.err
              - /var/log/mail.log
              - /var/log/daemon.log
              - /var/log/kern.log
              - /var/log/auth.log
              - /var/log/user.log
              - /var/log/lpr.log
              - /var/log/cron.log
              - /var/log/debug
              - /var/log/messages
            options:
              - rotate: 4
              - weekly
              - missingok
              - notifempty
              - compress
              - delaycompress
              - sharedscripts
              - postrotate: "reload rsyslog >/dev/null 2>&1 || true"
          - files:
              - /var/log/syslog
            options:
              - rotate: 7
              - daily
              - missingok
              - notifempty
              - delaycompress
              - compress
              - postrotate: "reload rsyslog >/dev/null 2>&1 || true"

Reference
=========

- http://www.linuxcommand.org/man_pages/logrotate8.html
