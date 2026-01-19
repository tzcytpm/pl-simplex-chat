#!/bin/bash

security create-keychain -p "" simplex.keychain
security set-keychain-settings -u simplex.keychain
security add-certificates -k simplex.keychain "Developer ID Application: Privateline X-Chat Ltd (5NN7GUYB6T).cer"
security add-certificates -k simplex.keychain "Developer ID Certification Authority.cer"
# Private key with access from any app
security import "Privateline X-Chat.p12" -P "" -k simplex.keychain -A
# Public key
security import "Privateline X-Chat.pem" -k simplex.keychain
