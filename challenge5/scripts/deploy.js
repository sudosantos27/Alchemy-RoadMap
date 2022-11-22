
const main = async () => {
  try {
    const nftContractFactory = await hre.ethers.getContractFactory("Bull&Bear");
    const nftContract = await nftContractFactory.deploy(10, "0xc907e116054ad103354f2d350fd2514433d57f6f");  // BTC/USD priceFeed Polyogn
    await nftContract.deployed();

    console.log("Contracted deployed to: ", nftContract.address);
    process.exit(0); // everything went good and we finish script
  } catch (error) {
    console.log(error);
    process.exit(1); // this means there has been an issue
  }
};

main();