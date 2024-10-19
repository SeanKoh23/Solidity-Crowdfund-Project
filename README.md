# Solidity-Crowdfund-Project

Description : 

This smart contract is a Crowdfunding contract prototype which allows people to contribute funds to support a campaign. If the contribution goal is reached before the deadline, the owner will be able to withdraw the total funds contributed, otherwise the contributors can get their funds back. 


Breakdown (more for personal learning purposes):

The smart contract begins with state variables to store important information of the contract, such as “totalContributions”, the total amount of money contributed so far. The events are used to log actions on the blockchain. For example, “funded” is emitted when someone contributes funds. The constructor runs once when the contract is deployed. The helper functions help to check the status of the campaign (if it is still running or has succeeded).


To test and deploy on Sepolia testnet using Remix:
- Download "Crowdfunding.sol" and open it in Remix
- Compile Crowdfunding.sol
- Change environment to "injected provider metamask" to test it on sepolia
- Select the account you wish to use as the "owner" of the crowdfund contract
- Fill in the name, target funds and deadline of the contract and deploy it. (note: target fund is in wei by default and will be used for testing purposes. deadline is in seconds so inputting 10000 will be around 2.7 hours later since it is in unix time format)
- Once contract is deployed, you can check that "isFundEnabled" gives True and "isFunded" gives False. The rest of the functions should also return their respective bool/value
- To simulate funding of contract, put the wallet address you wish to use to fund into the "fund" box. (use a different wallet address from the owner), and type in the amount of wei to fund in the value section above. Press "fund" to fund.
- Once totalContributions >= target, "isFundSuccess" should return True. This means the owner can withdraw the funds by pressing on "withdraw owner". In this case funders will no longer be able to withdraw since target has already been reached.
- In the case deadline is reached and target is not met, funders can click on "withdrawFunds" to get a refund of their fund amount back to their account. In this case, the owner will not be able to withdraw the totalContribution since isFundSuccess is False
