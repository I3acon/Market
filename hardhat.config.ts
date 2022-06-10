import { task } from 'hardhat/config'
import '@nomiclabs/hardhat-waffle'
require("@nomiclabs/hardhat-etherscan");
import 'hardhat-typechain';
require("hardhat-laika");

task('accounts', 'Prints the list of accounts', async (args, hre) => {
  const accounts = await hre.ethers.getSigners()
  for (const account of accounts) {
    console.log(await account.address)
  }
})

module.exports = {
  defaultNetwork: "kovan",
  networks: {
    hardhat: {
      forking: {
        url: "https://kovan.infura.io/v3/a4f7b70c34354ed4b1988216c9c24b48"
      }
    },
    kovan: {
      url: "https://kovan.infura.io/v3/a4f7b70c34354ed4b1988216c9c24b48",
      accounts: ["34afec3c082278a4478e340f8a17f0f471d2f064d7d2dd03d5d4e1cc87f80f17"]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "C6K85G9DIPR6XXNXCCV44IJ8Q2WSB1TX8D"
  },
  solidity: "0.8.13",
};