{% macro install_static(release_channel, netdata_version) %}

{% set sysarch = grains['cpuarch'] %}

{% if release_channel == 'nightly'  %}
{% set script_url = "https://storage.googleapis.com/netdata-nightlies/netdata-" ~ sysarch ~ "-latest.gz.run" %}
{% set hash_url = "https://storage.googleapis.com/netdata-nightlies/sha256sums.txt" %}
{% else %}
{% set script_url = "https://github.com/netdata/netdata/releases/download/v" ~ netdata_version ~ "/netdata-" ~ sysarch ~ "-v" ~ netdata_version ~".gz.run" %}
{% set hash_url = "https://github.com/netdata/netdata/releases/download/v" ~ netdata_version ~ "/sha256sums.txt" %}
{% endif %}

download_static_installer:
  file.managed:
    - source: {{ script_url }}
    - name: /tmp/netdata-{{ sysarch }}-latest.gz.run
    - source_hash: {{ hash_url }}
    - source_hash_name: "netdata-{{ sysarch }}-latest.gz.run"
    - unless: test -d /opt/netdata

install_nedata_static:
  cmd.run:
    - name: bash /tmp/netdata-{{ sysarch }}-latest.gz.run --accept
    - unless: test -d /opt/netdata

delete_static_installer:
  file.absent:
    - name: /tmp/netdata-{{ sysarch }}-latest.gz.run

{% endmacro %}
