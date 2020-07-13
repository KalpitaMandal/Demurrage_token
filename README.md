# Demurrage_token
A token to handle demurrage fees payment and maintain regualtions regarding transfer of given Deta Tokens. The open zeppelin library was used for token creation. The open zepellin library was called using the npm package:
```shell
npm install @openzeppelin/contracts --save
```
For deploying the smart contracts, trufllw suite was used. We begin with:
```shell
truffle init
```
Set up the ganache private blockchain environment for testing
```shell
truffle develop
```
Compile and migrate the contracts for testing:
```shell
truffle compile
```
```shell
truffle migrate --reset
```
Deploy the Deta token contract and the Dai token contract as follows:
```shell
let Dai = await daiToken.deployed()
let Deta = await DemmurageToken.deployed()
```
Mint the Deta tokens and assign them with assets for rendering the dollar value with the digital asset:
```shell
Deta.mint(1200,"Bicycle")
Deta.mint(1000,"Pool")
Deta.mint(1400,"Casino")
```
Approve the Deta token contract to receive and transfer payments from the Dai token contract:
```shell
Dai.approve(Deta.address, 100)
```
This give the approval of 100 Dai token to the Deta contract.
Transfer Dai tokens to the Deta contract for getting the initial payments for storing the Deta tokens:
```shell
Deta.TransferDai(Dai.address,3,1)
```
Check the balance of the Demurrage collector for the fees payment
```shell
await web3.eth.getBalance('0x583031D1113aD414F02576BD6afaBfb302140225')
```
