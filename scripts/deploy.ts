
import { ethers } from "hardhat";
import config from "../config.json"
import hre from "hardhat";
import ERC20_ABI from "../constant/ERC20.json";

async function main() {

  const Market = await ethers.getContractFactory("Market");
  const market = await Market.deploy(config.contracts.jusd.address);

  await market.deployed();

  console.log("Market Contract deployed to:", market.address);

  //  await hre.network.provider.request({
  //   method: "hardhat_impersonateAccount",
  //   params: [config.rich.address],
  // });
  // const signer = await ethers.getSigner(config.rich.address);
  // const daiContract = new ethers.Contract(config.contracts.dai.address, ERC20_ABI, signer);

  // await daiContract.connect(signer).transfer(config.account0.address, ethers.utils.parseEther("1000"));
  // const accountBalance = await daiContract.balanceOf(config.account0.address);

}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
