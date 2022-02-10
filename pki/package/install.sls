# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_enable_check = tplroot ~ '.check' %}
{%- from tplroot ~ "/map.jinja" import mapdata as pki with context %}

include:
  - {{ sls_enable_check }}

cert_import_pkg-install-pkg-installed:
  pkg.installed:
    - name: {{ pki.cert_import_pkg.name }}

key_import_pkg-install-pkg-installed:
  pkg.installed:
    - name: {{ pki.key_import_pkg.name }}
