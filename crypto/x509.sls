#!jinja|yaml

{% from "crypto/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('crypto:lookup')) %}

{% set keys = salt['pillar.get']('crypto:x509:keys', {}) %}

{% for k, v in keys|dictsort %}

  {% if 'mode' in v %}
    {% set mode = v.mode %}
  {% elif v.type|default('public') == 'private' %}
    {% set mode = '600' %}
  {% else %}
    {% set mode = '644' %}
  {% endif %}

  {% if 'path' in v %}
    {% set path = v.path %}
  {% else %}
    {% if v.type|default('public') == 'public' %}
      {% set path = datamap.x509.cert_pub_dir ~ '/' ~ k ~ '.' ~ v.key_suffix|default('crt') ~ '.pem' %}
    {% else %}
      {% set path = datamap.x509.cert_priv_dir ~ '/' ~ k ~ '.' ~ v.key_suffix|default('key') ~ '.pem' %}
    {% endif %}
  {% endif %}

  {% if 'content' in v %}
    {% set contents_pillar = 'crypto:x509:keys:' ~ k ~ ':content' %}
  {% else %}
    {% set contents_pillar = v.contents_pillar %}
  {% endif %}


crypto-x509-key-{{ k }}:
  file:
    - {{ v.ensure|default('managed') }}
    - name: {{ path }}
    - user: {{ v.user|default('root') }}
    - group: {{ v.group|default('root') }}
    - mode: {{ mode }}
  {% if 'contents_pillar_list' in v %}
    - contents: |
    {%- for c in v.contents_pillar_list %}
{{ salt['pillar.get'](c, '')|indent(8, True) }}
    {% endfor %}
  {% else %}
    - contents_pillar: {{ contents_pillar }}
  {% endif %}
{% endfor %}
