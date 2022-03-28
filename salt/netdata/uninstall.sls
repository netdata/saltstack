{% from 'netdata/macros/uninstall.sls' import uninstall_type %}

{% set check_install_type = pillar.get('check_install_type', 'static') %}
{{ uninstall_type(check_install_type) }}
