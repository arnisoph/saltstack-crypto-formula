#!jinja|yaml

{% from "crypto/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('crypto:lookup')) %}

{% set keys = salt['pillar.get']('crypto:gpg:keys', {}) %}
{% for k, v in keys|dictsort %}

  {% if v.mode is defined %}
    {% set mode = v.mode %}
  {% elif v.type|default('public') == 'private' %}
    {% set mode = '600' %}
  {% else %}
    {% set mode = '644' %}
  {% endif %}


  {% if 'content' in v %}
crypto_gpg_{{ k }}_key:
  file:
    - {{ v.ensure|default('managed') }}
    - name: {{ v.path }}
    - mode: {{ mode }}
    - user: {{ v.user|default('root') }}
    - group: {{ v.group|default('root') }}
    - contents_pillar: crypto:gpg:keys:{{ k }}:content
  {% else %}
    {% set batch_file_path = v.batch_file_path|default('/root/gpg_batch_' ~  salt['hashutil.sha256_digest'](k) ~ '.txt') %}
    {% if salt['cmd.retcode']('gpg --list-keys \'' ~  k ~ '\'') == 0 %}
      {% set key_exists = True %}
    {% else %}
      {% set key_exists = False %}
    {% endif %}

crypto_gpg_{{ k }}_batchfile:
  file:
    {% if key_exists %}
    - absent
    {% else %}
    - managed
    {% endif %}
    - name: {{ batch_file_path }}
    - mode: 600
    - user: root
    - group: root
    - contents_pillar: crypto:gpg:keys:{{ k }}:batch

crypto_gpg_{{ k }}_genkey:
  cmd:
    - run
    - name: gpg -v --gen-key --batch '{{ batch_file_path }}' && rm -f '{{ batch_file_path }}'
    - runas: root
    - cwd: /root/
    {% if key_exists %}
    - unless: /bin/true
    {% else %}
    - unless: /bin/false
    {% endif %}
  {% endif %}
{% endfor %}
