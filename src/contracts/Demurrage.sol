pragma solidity ^0.6.0;

import "node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "node_modules/@openzeppelin/contracts/token/ERC721/IERC721.sol";

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
    
    function mint(uint256 _value, string memory asset) public {
        require(!_assetExists[asset]);
        assets.push(Asset(tokenId,_value,asset));
        _mint(msg.sender, tokenId);
        _assetExists[asset] = true;
        tokenId++;
    }
    
    function transfer(uint256 _tokenId) public {
        require(now<deadline);
        string memory assetFound = findTokenAsset(_tokenId);
        require(_assetExists[assetFound] == true);
        transferFrom(msg.sender,address(this), _tokenId);
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
    
    function TransferDai(address DaiInstance, uint256 _timeperiod, uint _tokenId) public returns(uint256) {
        uint256 _tokenValue = findTokenValue(_tokenId);
        uint256 _amount = _tokenValue * _timeperiod * 1/1000;
        daiToken = IERC721(DaiInstance);
        daiToken.transferFrom(msg.sender,Demurrage_Collector, _amount);
        deadline = now + (_timeperiod * 1 days);
        return deadline;
    }
}