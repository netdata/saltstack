download_static_installer:
  file.managed:
    - source: https://github.com/netdata/netdata/releases/download/v1.33.1/netdata-x86_64-v1.33.1.gz.run
    - name: /tmp/netdata-x86_64-latest.gz.run
    - source_hash: https://github.com/netdata/netdata/releases/download/v1.33.1/sha256sums.txt
    - source_hash_name: netdata-x86_64-latest.gz.run
    - unless: test -d /opt/netdata

install_nedata_static:
  cmd.run:
    - name: bash /tmp/netdata-x86_64-latest.gz.run --accept
    - unless: test -d /opt/netdata

delete_static_installer:
  file.absent:
    - name: /tmp/netdata-x86_64-latest.gz.run
