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

Change parameters in main logrotate.conf file:

.. code-block:: yaml

    logrotate:
      server:
        enabled: true
        global_conf:
          compress: true
          rotate: daily
          keep_rotate: 6
          dateext: true

Cross-formula relationship
==========================

It's possible to use support meta to define logrotate rules from within other
formula.

Example ``meta/logrotate.yml`` for horizon formula:

.. code-block:: yaml

    job:
      horizon:
        - files:
            - /var/log/horizon/*.log
          options:
            - compress
            - delaycompress
            - missingok
            - notifempty
            - rotate: 10
            - daily
            - minsize: 20M
            - maxsize: 500M
            - postrotate: "if /etc/init.d/apache2 status > /dev/null; then /etc/init.d/apache2 reload > /dev/null; fi"

Reference
=========

- http://www.linuxcommand.org/man_pages/logrotate8.html

Documentation and Bugs
======================

To learn how to install and update salt-formulas, consult the documentation
available online at:

    http://salt-formulas.readthedocs.io/

In the unfortunate event that bugs are discovered, they should be reported to
the appropriate issue tracker. Use Github issue tracker for specific salt
formula:

    https://github.com/salt-formulas/salt-formula-logrotate/issues

For feature requests, bug reports or blueprints affecting entire ecosystem,
use Launchpad salt-formulas project:

    https://launchpad.net/salt-formulas

You can also join salt-formulas-users team and subscribe to mailing list:

    https://launchpad.net/~salt-formulas-users

Developers wishing to work on the salt-formulas projects should always base
their work on master branch and submit pull request against specific formula.

    https://github.com/salt-formulas/salt-formula-logrotate

Any questions or feedback is always welcome so feel free to join our IRC
channel:

    #salt-formulas @ irc.freenode.net
