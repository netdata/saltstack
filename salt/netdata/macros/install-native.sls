{% macro install_native(config) %}
{% set config = config.split(',') %}

install_netdata_repository:
  pkg.installed:
    - sources:
      - {{ config[1]|trim }}: {{ config[2]|trim }}
    - unless: {{ config[0]|trim }} {{ config[1]|trim }}

install_netdata:
  pkg.installed:
    - pkgs:
      - netdata: latest
    - refresh: True
    - require:
      - install_netdata_repository

{% endmacro %}
