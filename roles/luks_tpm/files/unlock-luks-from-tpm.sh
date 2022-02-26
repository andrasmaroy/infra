#!/bin/sh

echo "Unlock LUKS volume via TPM - $CRYPTTAB_SOURCE ($CRYPTTAB_NAME) ..." >&2
#Replace the persistent address if necessary (-Q: slient, only return unseal data)
/usr/bin/tpm2_unseal -Q -c 0x81000000
if [ $? -eq 0 ]; then
        exit 0
fi

#If failed (no matter of tpm2_unseal error or key not match), then fallback to ask passphrase
/lib/cryptsetup/askpass "Unlock LUKS volume fallback to passphrase - $CRYPTTAB_SOURCE ($CRYPTTAB_NAME)\nEnter passphrase: "
