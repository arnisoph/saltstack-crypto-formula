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
        path: /etc/ssl/certs/cunstone-ca.pem
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
  gpg:
    keys:
      duply_pub_key:
        path: /root/.duply/myprof_example2/gpgkey.F1D35B33.pub.asc
        content: |
          -----BEGIN PGP PUBLIC KEY BLOCK-----
          ...
          ...
          ...
          -----END PGP PUBLIC KEY BLOCK-----
      duply_prv_key:
        path: /root/.duply/myprof_example2/gpgkey.F1D35B33.sec.asc
        type: private
        mode: 640
        content: |
          -----BEGIN PGP PRIVATE KEY BLOCK-----
          ...
          ...
          ...
          -----END PGP PRIVATE KEY BLOCK-----
