{% from 'netdata/macros/netdata-config.sls' import netdata_config with context %}

{% set release_channel = pillar.get('release_channel', 'stable') %}
{% set check_install_type = pillar.get('check_install_type', '') %}
{% set config = netdata_config(release_channel)|trim %}
{% set netdata_version = pillar.get('netdata_version', '1.33.1') %}

{% if config.split(',')|length > 1 %}
{% if check_install_type != '' and check_install_type != 'native' %}
check_install_type:
  test.fail_without_changes:
    - name: "ERROR - install type does not match! Expected 'native' but found '{{ check_install_type }}'"
    - failhard: True
{% endif %}
perform_native_install:
  test.show_notification:
    - text: INFO - Performing Netdata "native" installation from "{{ release_channel }}" channel
{% from 'netdata/macros/install-native.sls' import install_native %}
{{ install_native(config) }}
{% else %}
{% if check_install_type != '' and check_install_type != 'static' %}
check_install_type:
  test.fail_without_changes:
    - name: "ERROR - install type does not match! Expected 'static' but found '{{ check_install_type }}'"
    - failhard: True
{% endif %}
perform_static_install:
  test.show_notification:
    - text: INFO - Performing Netdata "static" installation from "{{ release_channel }}" channel
{% from 'netdata/macros/install-static.sls' import install_static %}
{{ install_static(release_channel, netdata_version) }}
{% endif %}
