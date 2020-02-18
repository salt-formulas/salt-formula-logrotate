{%- if salt['pillar.get']('logrotate:server') %}
include:
- logrotate.server
{%- endif %}
