{%- from "logrotate/map.jinja" import server with context %}

{%- if server.enabled %}

logrotate_packages:
  pkg.installed:
    - names: {{ server.pkgs }}

{%- for name, job in server.job.iteritems() %}

logrotate_job_{{ name }}:
  file.managed:
    - name: {{ server.config_dir }}/{{ name }}
    - source: salt://logrotate/files/job.conf
    - template: jinja
    - require:
      - pkg: logrotate_packages
    - context:
        jobs: {{ job }}

{%- endfor %}

{%- endif %}
