# Generate an RSA keypair for the connection
# Fill in the password for the user and the public key below

/ip ssh set strong-crypto=yes
/user add name=ansible group=full password=""
/file print file=pubkey
/file set pubkey.txt contents=""
/user ssh-keys import public-key-file=pubkey.txt user=ansible
/file remove pubkey.txt
