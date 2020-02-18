{%- from "logrotate/map.jinja" import server with context %}

{%- if server.enabled %}

logrotate_packages:
  pkg.installed:
    - names: {{ server.pkgs }}

{%- set _jobs = server.get('job', {}) %}
{%- for service_name, service in pillar.items() %}
  {%- set support_fragment_file = service_name+'/meta/logrotate.yml' %}
  {%- macro load_support_file() %}{% include support_fragment_file ignore missing %}{% endmacro %}
  {%- set support_yaml = load_support_file()|load_yaml %}

  {%- if support_yaml and support_yaml.get('job', {}) %}
    {%- do _jobs.update(support_yaml.get('job', {})) %}
  {%- endif %}
{%- endfor %}

{%- for name, job in _jobs.items() %}

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

logrotate_conf:
  file.managed:
    - name: {{ server.config }}
    - source: salt://logrotate/files/logrotate.conf
    - template: jinja
    - require:
      - pkg: logrotate_packages

{%- endif %}
