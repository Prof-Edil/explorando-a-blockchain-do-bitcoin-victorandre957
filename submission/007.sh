# Only one single output remains unspent from block 123,321. What address was it sent to?

readarray -t blockTransactions < <(bitcoin-cli getblock "$(bitcoin-cli getblockhash 123321)" | jq -r .tx[])

for transaction in "${blockTransactions[@]}"
do  
    txid=$(bitcoin-cli getrawtransaction "$transaction" 1 | jq -c .)
    readarray -t outs < <(echo "$txid" | jq -c .vout[])

    for out in "${outs[@]}"
    do
        out_index=$(echo $out | jq -r .n)
        notUsed=$(bitcoin-cli gettxout $transaction $out_index)

        if [[ $notUsed ]]
        then
          echo $(echo $notUsed | jq -r .scriptPubKey.address)
        fi
    done
done