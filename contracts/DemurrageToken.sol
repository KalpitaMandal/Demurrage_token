pragma solidity ^0.6.0;

import "./ERC721.sol";
// import "./IERC721.sol";

contract DemurrageToken is ERC721 {
    
    struct Asset{
        uint id;
        uint256 value;
        string asset;
    }
    Asset[] public assets;
    
    mapping(string => bool) _assetExists;
    mapping(uint256 => Asset[]) _valueAsset;
    
    IERC721 daiToken;
    uint tokenId = 1;
    address payable Demurrage_Collector = 0x583031D1113aD414F02576BD6afaBfb302140225;
    uint256 deadline;
    
    
    constructor() ERC721("Demurrage Token", "DETA") public {
    }
    
    function AddAsset(uint256 _value, string memory asset) public {
        require(!_assetExists[asset]);
        assets.push(Asset(tokenId,_value,asset));
        _assetExists[asset] = true;
        tokenId++;
    }
    
    function transfer(uint256 _tokenId, address _to) public {
        require(now<deadline);
        string memory assetFound = findTokenAsset(_tokenId);
        require(_assetExists[assetFound] == true);
        transferFrom(msg.sender,_to, _tokenId);
    }
    
    function findTokenAsset(uint256 _tokenId) public view returns(string memory) {
        for(uint i = 0; i < assets.length; i++){
            if(assets[i].id == _tokenId){
                return assets[i].asset;
            }
        }
    }
    
    function findTokenValue(uint256 _tokenId) public view returns(uint256) {
        for(uint i = 0; i < assets.length; i++){
            if(assets[i].id == _tokenId){
                return assets[i].value;
            }
        }
    }
    function getDays() public returns(uint256) {
        uint256 DaysLeft = deadline - now;
        return(DaysLeft * 1/1 days);
    }
    
    function TransferDai(address DaiInstance, uint256 _timeperiodDays, uint256 _timeperiodHours, uint _tokenId) public returns(uint256) {
        uint256 _tokenValue = findTokenValue(_tokenId);
        uint256 fraction = 24/_timeperiodHours;
        uint256 newDays = (_timeperiodDays * fraction) + 1;
        uint256 _amount = _tokenValue * newDays * 1/fraction * 1/1000;
        daiToken = IERC721(DaiInstance);
        daiToken.transferFrom(msg.sender, Demurrage_Collector, _amount);
        _mint(msg.sender,_tokenId);
        deadline = now + ((_timeperiodDays * 1 days) + ((_timeperiodHours/24)* 1 days));
        return deadline;
    }
}
