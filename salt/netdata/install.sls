{% from 'netdata/macros/netdata-config.sls' import netdata_config with context %}

{% set release_channel = pillar.get('release_channel', 'stable') %}
{%- set config = netdata_config(release_channel) -%}

{% if config.split(',')|length > 2 %}
{% from 'netdata/macros/install-native.sls' import install_native %}
{{ install_native(config) }}
{% else %}
{% from 'netdata/macros/install-static.sls' import install_static %}
{{ install_static(release_channel) }}
{% endif %}


