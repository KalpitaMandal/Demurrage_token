const DemurrageToken = artifacts.require('DemurrageToken');
const DaiToken = artifacts.require('daiToken');

contract('DaiToken', () => {
    let Dai;
    before(async () => {
        Dai = await DaiToken.deployed()
    })

    describe('Dai Toekn Deployment', async() => {
        it('Deploys successfully', async() => {
            const daiaddress = Dai.address
            assert.notEqual(daiaddress, '')
            assert.notEqual(daiaddress, 0x0 )
            assert.notEqual(daiaddress, undefined)
            assert.notEqual(daiaddress, null)
        })

        it('Should have a name', async() => {
            const dainame = await Dai.name()
            assert.equal(dainame, 'daitoken')
        })

        it('Should have a symbol', async() => {
            const daisymbol = await Dai.symbol()
            assert.equal(daisymbol, 'DAI')
        })
    })
})

contract('DemurrageToken', () => {
    let contract;
    let accounts;

    before(async () => {
        contract = await DemurrageToken.deployed()
        accounts = await web3.eth.getAccounts()
    })

    describe('Demurrage Token Deployment', async() => {
        it('Deploys successfully',async () => {
            const address = contract.address
            assert.notEqual(address, '')
            assert.notEqual(address, 0x0 )
            assert.notEqual(address, undefined)
            assert.notEqual(address, null)
        })

        it('Should have a name', async() => {
            const name = await contract.name()
            assert.equal(name, 'Demurrage Token')
        })

        it('Should have a symbol', async() => {
            const symbol = await contract.symbol()
            assert.equal(symbol, 'DETA')
        })
    })

    describe('Demurrage Token Adding assets', async() => {
        it('Should add assets and related values to the array', async() => {
            await contract.AddAsset(1200,'Crown')
            const asset = await contract.findTokenAsset(1)
            const value = await contract.findTokenValue(1)
            assert.equal(asset, 'Crown')
            assert.equal(value, 1200)
        })
    })

    describe('Minting', async() => {

        it('Approves the Deta token contract address', async() => {
            const daiInstance = await DaiToken.deployed()
            await daiInstance.approve(contract.address, 1000)
            const result = await daiInstance.allowance(accounts[0],contract.address)
            assert.equal(result, 1000)
        })

        it('Sends new tokens to sender address', async() => {
            const daiInstance = await DaiToken.deployed()
            await daiInstance.approve(contract.address, 1000)
            const result = await contract.TransferDai(daiInstance.address,2,12,1)
            assert.equal(result.logs[0].args[2].words[0], 1,'Token ID is correct')
            assert.equal(result.logs[0].args[0], '0x0000000000000000000000000000000000000000', 'From address is correct')
            assert.equal(result.logs[0].args[1], accounts[0], 'To address is correct')
            assert.equal(result.logs[0].args[2].length, 1, 'Number of tokens is correct')
        })
    })

    describe('Transfer', async() => {

        it('Check if transfer can be called', async() => {
            const daysLeft = await contract.getDays()
            assert.equal(daysLeft.words[0], 2) 
        })

        it('Transfer is successful', async() => {
            await contract.transfer(1,accounts[9])
            const balance = await contract.balanceOf(accounts[9])
            assert.equal(balance,1)
        })
    })
})