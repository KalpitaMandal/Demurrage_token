# Demurrage_token
A token to handle demurrage fees payment and maintain regualtions regarding transfer of given Deta Tokens. The open zeppelin library was used for token creation. The open zepellin library was called using the npm package:
```shell
npm install @openzeppelin/contracts --save
```
Since running the setup on private blockchain, we assume the erc20 tokens are dai tokens and proceed with the below process.

For deploying the smart contracts, truflle suite was used. We begin with:
```shell
truffle init
```
Test the contract before deploying it on the private blockchain
```
truffle test
```
Set up the ganache private blockchain environment for testing
```shell
truffle develop
```
Compile and migrate the contracts for testing:
```shell
truffle compile
truffle migrate --reset
```
Deploy the Deta token contract and the Dai token contract as follows:
```shell
let Dai = await daiToken.deployed()
let Deta = await DemurrageToken.deployed()
let accounts = await web3.eth.getAccounts()
```
Mint the Deta tokens and assign them with assets for rendering the dollar value with the digital asset:
```shell
Deta.AddAsset(1200,"Car")
Deta.AddAsset(1000,"IphoneX")
Deta.AddAsset(1400,"Villa")
```
Approve the Deta token contract to receive and transfer payments from the Dai token contract:
```shell
Dai.approve(Deta.address, 100)
```
This give the approval of 100 Dai token to the Deta contract.

Transfer Dai tokens to the Deta contract for getting the initial payments for storing the Deta tokens.
```shell
Deta.TransferDai(Dai.address,2,12,1)
```
Check the balance of the Demurrage collector for the fees payment
```shell
Dai.balanceOf('0x583031D1113aD414F02576BD6afaBfb302140225')
```
Transfer the Token to another address within the duration of the prepaid period
```shell
Deta.transfer(1,accounts[9])
```
Check the balance of the receiver account
```shell
Deta.balanceOf(accounts[9])
```
Check the Number of days left for the paid period
```
Deta.getDays()
```
