{% macro install_native(config) %}
{% set config = config.split(',') %}


{% if grains['os'] == 'SUSE' %}
netdata_repo:
  pkgrepo.managed:
    - baseurl: https://packagecloud.io/netdata/netdata/opensuse/$releasever/$basearch
    - key_url: https://packagecloud.io/netdata/netdata/gpgkey
    - gpgcheck: True
    - gpgautoimport: True

netdata_repoconfig:
  pkgrepo.managed:
    - baseurl: https://packagecloud.io/netdata/netdata-repoconfig/opensuse/$releasever/$basearch
    - key_url: https://packagecloud.io/netdata/netdata-repoconfig/gpgkey
    - gpgcheck: True
    - gpgautoimport: True
{% endif %}

install_netdata_repository:
  pkg.installed:
    - sources:
      - {{ config[0]|trim }}: {{ config[1]|trim }}
    - skip_verify: True
    - skip_suggestions: True
    - pkg_verify: False

install_netdata:
  pkg.installed:
    - pkgs:
      - netdata: latest
    - refresh: True
    - require:
      - install_netdata_repository
      {% if grains['os'] == 'SUSE' %}
      - netdata_repo
      - netdata_repoconfig
      {% endif %}
{% endmacro %}
