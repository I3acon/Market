
import { ethers } from "hardhat";
import config from "../config.json"
import hre from "hardhat";
import ERC20_ABI from "../constant/ERC20.json";

async function main() {

  const Market = await ethers.getContractFactory("Market");
  const market = await Market.deploy(config.contracts.jusd.address);

  await market.deployed();

   await hre.network.provider.request({
    method: "hardhat_impersonateAccount",
    params: [config.rich.address],
  });
  const signer = await ethers.getSigner(config.rich.address);
  const jusdContract = new ethers.Contract(config.contracts.jusd.address, ERC20_ABI, signer);

  await jusdContract.connect(signer).transfer(config.account0.address, ethers.utils.parseEther("10000"));
  const accountBalance = await jusdContract.balanceOf(config.account0.address);

  console.log("Market Contract deployed to:", market.address);

    await hre.run("laika-sync", {
    contract: "Market",
    address: market.address,
  })

   
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
