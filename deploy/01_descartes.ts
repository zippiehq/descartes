import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
    const { deployments, getNamedAccounts } = hre;
    const { deploy, get } = deployments;
    const { deployer } = await getNamedAccounts();

    const MerkleV3 = await get("MerkleV3");
    const Logger = await get("Logger");
    const VGInstantiator = await get("VGInstantiator");
    const Step = await get("Step");

    await deploy("CartesiCompute", {
        from: deployer,
        log: true,
        libraries: {
            MerkleV3: MerkleV3.address,
        },
        args: [Logger.address, VGInstantiator.address, Step.address],
    });
};

export default func;
export const tags = ["CartesiCompute"];
