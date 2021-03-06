# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata without context %}

{% if not mapdata.enabled %}
pki/enabled/false:
  test.configurable_test_state:
    - result: false
    - changes: false
    - comment: The pki formula is not enabled for this minion, abort
    - failhard: true
{% endif %}