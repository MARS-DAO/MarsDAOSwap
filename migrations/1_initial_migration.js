const MarsDAO = artifacts.require("MarsDAO");
const MarsDaoSwap= artifacts.require("MarsDaoSwap");

module.exports = async (deployer, network) => {
  
  if (network == "bscmain") {
    const oldToken="0x4eC57B0156564DDdEa375F313927ec2DDc975D69";
    try{
      await deployer.deploy(MarsDAO);
      await deployer.deploy(MarsDaoSwap,oldToken,MarsDAO.address);
    }catch(err){
      console.log("ERROR:",err);
    }
  }
};
