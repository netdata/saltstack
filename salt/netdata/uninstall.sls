{% if grains['os'] == 'SUSE' %}
netdata_repo:
  pkgrepo.absent:
    - name: netdata_repo

netdata_repoconfig_suse:
  pkgrepo.absent:
    - name: netdata_repoconfig

{% endif %}

remove_netdata:
  pkg.purged:
    - pkgs:
      - netdata
      - netdata-repo
      - netdata-repo-edge
