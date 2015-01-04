crypto:
  x509:
    keys:
      suntone_key:
        path: /etc/ssl/private/sunstone.key
        type: private
        mode: 640
        group: oneadmin
        contents: |
          -----BEGIN RSA PRIVATE KEY-----
          ...
          ...
          ...
          -----END RSA PRIVATE KEY-----
      sunstone_ca:
        path: /etc/ssl/certs/sunstone-ca.pem
        contents: |
          -----BEGIN CERTIFICATE-----
          ...
          ...
          ...
          -----END CERTIFICATE-----
      sunstone_cert_merged:
        path: /etc/ssl/certs/sunstone-crt_merged.pem
        contents_pillar_list:
          - 'tls_internal:keys:32_62_C5_12_01_crt:content'
          - 'tls_internal:keys:32_62_C5_12_01_ca:content'
      sunstone_cert:
        path: /etc/ssl/certs/sunstone.pem
        contents: |
          -----BEGIN CERTIFICATE-----
          ...
          ...
          ...
          -----END CERTIFICATE-----
  gpg:
    keys:
      duply_pub_key:
        path: /root/.duply/myprof_example2/gpgkey.F1D35B33.pub.asc
        contents: |
          -----BEGIN PGP PUBLIC KEY BLOCK-----
          ...
          ...
          ...
          -----END PGP PUBLIC KEY BLOCK-----
      duply_prv_key:
        path: /root/.duply/myprof_example2/gpgkey.F1D35B33.sec.asc
        type: private
        mode: 640
        contents: |
          -----BEGIN PGP PRIVATE KEY BLOCK-----
          ...
          ...
          ...
          -----END PGP PRIVATE KEY BLOCK-----

      duply_keypair:
        batch: |
            %echo GEN START
            Key-Type: RSA
            Key-Length: 4096
            Subkey-Type: RSA
            Subkey-Length: 4096
            Name-Real: duply_keypair
            Name-Email: hostmaster@domain.de
            Expire-Date: 0
            Passphrase: RictE5NUZEV_h4OixZEkqF63CNjxq942
            %commit
            %echo GEN DONE
  dh:
    params:
      postfix_dh_param_512:
        numbits: 512
        path: /etc/postfix/dh_512.pem
      postfix_dh_param_1024:
        numbits: 1024
        path: /etc/postfix/dh_1024.pem
      postfix_dh_param_2048:
        numbits: 2048
        path: /etc/postfix/dh_2048.pem
