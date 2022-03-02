install_dependencies:
  pkg.installed:
    - pkgs:
      - wget: latest

install_netdata_repository:
  pkg.installed:
    - sources:
      - {{ repo_pkg_name }}: {{ repo_url }}
    - unless: {{ query_cmd }} {{ repo_pkg_name }}

install_netdata:
  pkg.installed:
    - pkgs:
      - netdata: latest
    - refresh: True
    - require:
      - install_netdata_repository
