How to Develop an NFT Smart Contract (ERC721) with Alchemy

1. We create the ERC721 Smart Contract and deploy it
2. Edit metadata
3. Store image on Filebase
    Create Bucket, storage network IPFS
    Upload image in bucket
4. Copy IPFS Gateway URL and paste it on JSON metadata, in image. Edit attributes and save JSON
5. In Filebase > go to the bucket > upload metadata.json
6. In Remix we mint NFT with safeMint function. Paste address and URI is ipfs://IPFS_CID. To ckeck it use function balanceOf
7. In tokenURI function write 0 and will give you tokenURI
8. Check on testnet opensea if your nft is in your account