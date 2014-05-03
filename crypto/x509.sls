{% from "crypto/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('crypto:lookup')) %}

{% set keys = salt['pillar.get']('crypto:x509:keys', {}) %}
{% for k, v in keys.items() %}

  {% if v.mode is defined %}
    {% set mode = v.mode %}
  {% elif v.type|default('public') == 'private' %}
    {% set mode = '600' %}
  {% else %}
    {% set mode = '644' %}
  {% endif %}


crypto-x509-key-{{ k }}:
  file:
    - {{ v.ensure|default('managed') }}
    - name: {{ v.path }}
    - user: {{ v.user|default('root') }}
    - group: {{ v.group|default('root') }}
    - mode: {{ mode }}
    - contents_pillar: crypto:x509:keys:{{ k }}:content
{% endfor %}
