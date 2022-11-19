
const main = async () => {
  try {
    const nftContractFactory = await hre.ethers.getContractFactory("ChainBattles");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();

    console.log("Contracted deployed to: ", nftContract.address);
    process.exit(0); // everything went good and we finish script
  } catch (error) {
    console.log(error);
    process.exit(1); // this means there has been an issue
  }
};

main();