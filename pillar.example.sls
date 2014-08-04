crypto:
  x509:
    keys:
      suntone_key:
        path: /etc/ssl/private/sunstone.key
        type: private
        mode: 640
        group: oneadmin
        content: |
          -----BEGIN RSA PRIVATE KEY-----
          ...
          ...
          ...
          -----END RSA PRIVATE KEY-----
      sunstone_ca:
        path: /etc/ssl/certs/sunstone-ca.pem
        content: |
          -----BEGIN CERTIFICATE-----
          ...
          ...
          ...
          -----END CERTIFICATE-----
      sunstone_cert:
        path: /etc/ssl/certs/sunstone.pem
        content: |
          -----BEGIN CERTIFICATE-----
          ...
          ...
          ...
          -----END CERTIFICATE-----
