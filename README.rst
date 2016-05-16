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

.. literalinclude:: tests/pillar/service.sls
   :language: yaml

Reference
=========

- http://www.linuxcommand.org/man_pages/logrotate8.html
