{% macro netdata_config(release_channel) %}
{% set config = [] %}
{% import_yaml 'netdata/os_map.yml' as os_map %}
{% set os = grains['os'] %}
{% set osrelease = grains['osrelease'] %}
{% set osmajorrelease = grains['osmajorrelease'] %}

{% set osrelease_array = osrelease.split('.') %}
{% if osrelease_array|length > 1 %}
{% set osrelease = osrelease_array[0]|trim ~ '.' ~ osrelease_array[1]|trim %}
{% endif %}

{% if release_channel == 'nightly' %}
{% do config.append('netdata-repo-edge') %}
{% else %}
{% do config.append('netdata-repo') %}
{% endif %}

{% if os in os_map %}
{% set version_map = os_map[os][release_channel]['version_map'] %}
{% for version_info in version_map %}
{% if osrelease in version_info['versions'] or osmajorrelease in version_info['versions'] %}
{% do config.append(version_info['repo_url']|trim) %}
{% endif %}
{% endfor %}
{% endif %}
{{ config|join(",") }}
{% endmacro %}
