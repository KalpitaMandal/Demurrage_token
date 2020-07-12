const { assert } = require('chai')

const Demurrage = artifacts.require('./Demurrage.sol')

require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('Demurrage', (accounts) => {
    let contract

    before(async () => {
        contract = await Demurrage.deployed()
    })
    
    describe('Deployment', async () => {
        it('Deploys Successfully', async () => {
            contract = await Demurrage.deployed()
            const address = contract.address
            // console.log(address)
            assert.notEqual(address, '')
            assert.notEqual(address, 0x0)
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })

        it('Has a name', async () => {
            const name = await contract.name()
            assert.equal(name, 'Demurrage')
        })

        it('Has a symbol', async () => {
            const symbol = await contract.symbol()
            assert.equal(symbol, 'DETA')
        })
    })

    describe('Minting', async () => {
        it('Creates a new token', async () => {
            const result = await contract.mint(10)
            const totalSupply = await contract.totalSupply()
            //SUCCESS
            assert.equal(totalSupply,1)
            const event = result.logs[0].args
            assert.equal(event.tokenId.toNumber(), 1, 'Id is correct')
            assert.equal(event.from, '0x0000000000000000000000000000000000000000', 'From address is correct')
            assert.equal(event.to, accounts[0], 'To Address is correct')
            
            // FAILURE: cannot mint the same token twice
            // await contract.mint(10).should.be.rejected;
        })
    })
})