# How many new outputs were created by block 123,456?

block_outputs=$(bitcoin-cli getblockstats 123456 | jq .outs)

echo $block_outputs