# Which tx in block 257,343 spends the coinbase output of block 256,128?

usedBlock=$(bitcoin-cli getblockhash 256128)
spentBlock=$(bitcoin-cli getblockhash 257343)

coinbaseTxid=$(bitcoin-cli getblock $usedBlock | jq -r '.tx[0]')

transactionsMade=$(bitcoin-cli getblock $spentBlock | jq -r .tx[])

coinbaseVout=0

for transactions in $transactionsMade
do 
  readarray -t inputs < <(bitcoin-cli getrawtransaction $transactions 1 | jq -c .vin[])

  for i in "${inputs[@]}"
  do
    transactionPrevTxid=$(echo "$i" | jq -r .txid)
    transactionPrevVout=$(echo "$i" | jq -r .vout)

    if [[ $coinbaseTxid == $transactionPrevTxid && $coinbaseVout == $transactionPrevVout ]]
    then
        echo $transactions
        exit 0
    fi
  done
done