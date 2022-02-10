# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- set sls_enable_check = tplroot ~ '.check' %}
{%- from tplroot ~ "/map.jinja" import mapdata as pki with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_enable_check }}
  - {{ sls_config_file }}

pki-subcomponent-config-file-file-managed:
  file.managed:
    - name: {{ pki.subcomponent.config }}
    - source: {{ files_switch(['subcomponent-example.tmpl'],
                              lookup='pki-subcomponent-config-file-file-managed',
                              use_subpath=True
                 )
              }}
    - mode: 644
    - user: root
    - group: {{ pki.rootgroup }}
    - makedirs: True
    - template: jinja
    - require_in:
      - sls: {{ sls_config_file }}
