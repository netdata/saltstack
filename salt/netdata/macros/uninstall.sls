{% macro uninstall_type(check_install_type) %}

{% if check_install_type != '' and check_install_type != 'native' %}
remove_netdata_static:
  file.absent:
    - names:
      - /opt/netdata
      - /run/netdata
      - /etc/logrotate.d/netdata
      - /etc/init.d/netdata
      - /lib/systemd/system/netdata.service
{% else %}
{% if grains['os'] == 'SUSE' %}
netdata_repo:
  pkgrepo.absent:
    - name: netdata_repo
netdata_repoconfig_suse:
  pkgrepo.absent:
    - name: netdata_repoconfig
{% endif %}
remove_netdata_native:
  pkg.purged:
    - pkgs:
      - netdata
      - netdata-repo
      - netdata-repo-edge
{% endif %}
{% endmacro %}
