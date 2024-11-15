# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

txId="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

transaction=$(bitcoin-cli getrawtransaction $txId 1)

pubKeys=$(echo $transaction | jq -r '.vin[].txinwitness[1]')

pubKeysList=$(echo $pubKeys | sed 's/ /", "/g' | sed 's/^/["/;s/$/"]/')

P2SHAddress=$(bitcoin-cli createmultisig 1 "$pubKeysList" "legacy" | jq -r .address)

echo $P2SHAddress
