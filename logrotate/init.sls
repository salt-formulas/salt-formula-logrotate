include:
{%- if pillar.logrotate.server is defined %}
- logrotate.server
{%- endif %}
