{% if grains.os == 'CentOS' %}
{% set command = 'wget --content-disposition https://packagecloud.io/netdata/netdata/packages/el/8/netdata-repo-1-1.noarch.rpm/download.rpm -O /tmp/netdata-repo-1-1.noarch.rpm' %}
{% set package_path = '/tmp/netdata-repo-1-1.noarch.rpm' %}
{% else %}
{% set package_path = '/tmp/netdata-repo_1-1_all.deb' %}
{% set command = 'wget --content-disposition https://packagecloud.io/netdata/netdata/packages/ubuntu/focal/netdata-repo_1-1_all.deb/download.deb -O' ~ ' ' ~ package_path %}
{% endif %}

download_netdata_repo:
  cmd.run:
    - name: command
    - unless: rpm -q netdata-repo || dpkg -s netdata-repo

install_netdata_repository:
  pkg.installed:
    - sources:
      - netdata-repo: {{ package_path }}

install_netdata:
  pkg.installed:
    - pkgs:
      - netdata
    - refresh: True
