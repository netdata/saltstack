{% import_yaml 'netdata/os_map.yml' as os_map %}

{% set release_channel = pillar.get('release_channel', 'stable') %}

{% set os = grains['os'] %}
{% set os_version = grains['osrelease_info'][0] %}

{% set query_cmd = os_map[os]['query_cmd'] %}
{% set package_path = os_map[os][release_channel]['package_path'] %}
{% set repo_pkg_name = os_map[os][release_channel]['repo_pkg_name'] %}
{% set default = os_map[os][release_channel]['default_version'] %}
{% set repo_url = os_map[os][release_channel].get(os_version, default).get('repo_url', default['repo_url']) %}

install_dependencies:
  pkg.installed:
    - pkgs:
      - wget: latest

install_netdata_repository:
  pkg.installed:
    - sources:
      - {{ repo_pkg_name }}: {{ repo_url }}
    - unless: {{ query_cmd }} {{ repo_pkg_name }}

install_netdata:
  pkg.installed:
    - pkgs:
      - netdata: latest
    - refresh: True
    - require:
      - install_netdata_repository

cleanup_netdata_tempfile:
  file.absent:
    - names:
      - {{ package_path }}
