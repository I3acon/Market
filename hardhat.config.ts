import { task } from 'hardhat/config'
import '@nomiclabs/hardhat-waffle'
require("@nomiclabs/hardhat-etherscan");
import 'hardhat-typechain';

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
    },
    kovan: {
      url: "https://kovan.poa.network/",
      accounts: ["6c757a27f1b6a3eb87a7b28a6dd77145138eaefbc4c572a55a785eb897a292ed"]
    }
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: "C6K85G9DIPR6XXNXCCV44IJ8Q2WSB1TX8D"
  },
  solidity: "0.8.13",
};