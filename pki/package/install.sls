# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_enable_check = tplroot ~ '.check' %}
{%- from tplroot ~ "/map.jinja" import mapdata as pki with context %}

include:
  - {{ sls_enable_check }}

pki-package-install-pkg-installed:
  pkg.installed:
    - name: {{ pki.pkg.name }}
