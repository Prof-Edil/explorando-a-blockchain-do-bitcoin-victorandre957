# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"

# taproot 100 derviation path: m/86h/0h/0h/0/100
descriptorInfo100=$(bitcoin-cli getdescriptorinfo "tr($xpub/100)" | jq -r .descriptor)

taproot100=$(bitcoin-cli deriveaddresses $descriptorInfo100 | jq -r .[0])

echo $taproot100