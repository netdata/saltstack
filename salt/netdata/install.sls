download_netdata_repo:
  cmd.run:
    - name: wget --content-disposition https://packagecloud.io/netdata/netdata/packages/el/8/netdata-repo-1-1.noarch.rpm/download.rpm -O /tmp/netdata-repo-1-1.noarch.rpm
    - unless: rpm -q netdata

install_netdata_repository:
  pkg.installed:
    - sources:
      - netdata-repo: /tmp/netdata-repo-1-1.noarch.rpm

install_netdata:
  pkg.installed:
    - pkgs:
      - netdata
    - refresh: True
