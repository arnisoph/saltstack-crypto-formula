#!jinja|yaml

{% from "crypto/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('crypto:lookup')) %}

{% set params = salt['pillar.get']('crypto:dh:params', {}) %}
{% for k, v in params|dictsort %}
crypto_dhparam_{{ k }}:
  cmd:
    - run
    - name: openssl dhparam -out {{ v.path }} -{{ v.gen|default(2) }} {{ v.numbits|default(1024) }}
    - user: {{ v.user|default('root') }}
    - unless: test -f {{ v.path }}
{% endfor %}
