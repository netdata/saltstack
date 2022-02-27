{% macro netdata_config(release_channel) %}
{% set config = [] %}
{% import_yaml 'netdata/os_map.yml' as os_map %}
{% set os = grains['os'] %}
{% set osrelease = grains['osrelease'] %}

{% set osrelease_array = osrelease.split('.') %}
{% if osrelease_array|length > 1 %}
{% set osrelease = osrelease_array[0]|trim ~ '.' ~ osrelease_array[1]|trim %}
{% endif %}

{% set query_cmd = os_map[os]['query_cmd'] %}
{% do config.append(query_cmd|trim) %}
{% set repo_pkg_name = os_map[os][release_channel]['repo_pkg_name'] %}
{% do config.append(repo_pkg_name|trim) %}
{% set version_map = os_map[os][release_channel]['version_map'] %}
{% for version_info in version_map %}
{% if osrelease in version_info['versions'] %}
{% do config.append(version_info['repo_url']|trim) %}
{% endif %}
{% endfor %}
{{ config|join(",") }}
{% endmacro %}
