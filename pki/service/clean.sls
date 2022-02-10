# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as pki with context %}

pki-service-clean-service-dead:
  service.dead:
    - name: {{ pki.service.name }}
    - enable: False
