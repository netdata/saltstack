install_dependencies:
  pkg.installed:
    - pkgs:
      - wget: latest

{% if grains.os_family != 'Debian' %}

{% set netdata_repo_url = 'https://packagecloud.io/netdata/netdata/packages/el/8/netdata-repo-1-1.noarch.rpm/download.rpm' %}
{% set package_path = '/tmp/netdata-repo-1-1.noarch.rpm' %}

install_netdata_repository:
  pkg.installed:
    - sources:
      - netdata-repo: {{ netdata_repo_url }}
    - unless: rpm -q netdata-repo

{% else %}

{% set netdata_repo_url = 'https://packagecloud.io/netdata/netdata/packages/ubuntu/focal/netdata-repo_1-1_all.deb/download.deb' %}
{% set package_path = '/tmp/netdata-repo_1-1_all.deb' %}

install_netdata_repository:
  pkg.installed:
    - sources:
      - netdata-repo: {{ netdata_repo_url }}
    - unless: dpkg -S netdata-repo

{% endif %}

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
