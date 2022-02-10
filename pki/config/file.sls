# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- set sls_enable_check = tplroot ~ '.check' %}
{%- from tplroot ~ "/map.jinja" import mapdata as pki with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_enable_check }}
  - {{ sls_package_install }}

pki-config-file-file-managed:
  file.managed:
    - name: {{ pki.config }}
    - source: {{ files_switch(['example.tmpl'],
                              lookup='pki-config-file-file-managed'
                 )
              }}
    - mode: "0644"
    - user: root
    - group: {{ pki.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        pki: {{ pki | json }}
