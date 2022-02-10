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

# Slightly different arguments depending on OS family
{% if salt['grains.get']('os_family') == 'Debian' %}
  {% set argument = ' ' %}
{% else %}
  {% set argument = '/' + rpmkeys.local_cert_store + '/' + certname %}
{% endif %}


# Loop through the pubcerts pillar
{% for certname, certtext in salt['pillar.get']('pki:lookup:pubcerts',{}).items() %}
{{ certname }}-cert-config-file-file-managed:
  file.managed:
    - name: {{ pki.local_cert_store }}/{{ certname }}.crt
    - contents: |
        {{ certtext | indent(8) }}
    - mode: "0644"
    - user: root
    - group: root
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
  cmd.run:
    - name: {{ pki.cert_import_command }} {{ argument }}
    - onchanges_any:
      - file: {{ certname }}-cert-config-file-file-managed

# Loop through the pubkeys pillar
{% for keyname, keytext in salt['pillar.get']('pki:lookup:pubkeys',{}).items() %}
{{ keyname }}-key-config-file-file-managed:
  file.managed:
    - name: {{ pki.local_key_store }}/{{ keyname }}.crt
    - contents: |
        {{ keyname | indent(8) }}
    - mode: "0644"
    - user: root
    - group: root
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
  cmd.run:
    - name: {{ pki.key_import_command }}/{{ keyname }}
    - onchanges_any:
      - file: {{ keyname }}-key-config-file-file-managed
