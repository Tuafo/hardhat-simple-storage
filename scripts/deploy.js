// imports
const { ethers, run, network } = require("hardhat")

// async main
async function main() {
    const SimpleStorageFactory = await ethers.getContractFactory(
        "SimpleStorage"
    )
    console.log("Deploying contract...")
    const simpleStorage = await SimpleStorageFactory.deploy()
    await simpleStorage.deployed()
    console.log(`Deployed contract to: ${simpleStorage.address}`)

    // what happens when we deploy to our hardhat network?
    // console.log(network.config)
    // verify contract
    if (network.config.chainId === 11155111 && process.env.ETHERSCAN_API_KEY) {
        console.log("waiting for 6 block confirmations...")
        await simpleStorage.deployTransaction.wait(6)
        await verify(simpleStorage.address, [])
    }

    const currentValue = await simpleStorage.retrieve()
    console.log(`Current value stored in contract: ${currentValue.toString()}`)

    // update the current value
    const transactionResponse = await simpleStorage.Store(13)
    await transactionResponse.wait(1)
    const updatedValue = await simpleStorage.retrieve()
    console.log(`Updated value stored in contract: ${updatedValue.toString()}`)
}

async function verify(contractAddress, args) {
    console.log("Verifying contract...")
    try {
        await run("verify:verify", {
            address: contractAddress,
            constructorArguments: args,
        })
    } catch (e) {
        if (e.message.toLowerCase().includes("already verified")) {
            console.log("Contract already verified")
        } else {
            console.log(e)
        }
    }
}

// main
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    })
