Init scripts to configure:
- Helm with Tiller
- Nginx ingress controller
- cert-manager for LE
- kubed


Call the init script in a new folder. It will download all the files there.

Change the vars.sh to fit your needs.

It is assumed that you are using a GKE cluster and Route53 for DNS.

`sed -i 's/\*.borg.dev/\*.yourdomain.com/g' cert.yaml`

`sed -i 's/\*.borg.dev/\*.yourdomain.com/g' issuer.yaml`


Once you are ready run `bash helm.sh`.