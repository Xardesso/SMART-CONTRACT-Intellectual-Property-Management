// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IntellectualPropertyManagement {
    struct IntellectualProperty {
        address owner;
        string name;
        uint256 registrationDate;
    }
    mapping(uint256 => IntellectualProperty) private intellectualProperties;
    uint256 public totalProperties;
    
    event PropertyRegistered(uint256 indexed propertyId, address indexed owner, string name, uint256 registrationDate);
    event PropertyTransferred(uint256 indexed propertyId, address indexed previousOwner, address indexed newOwner, uint256 transferDate);
    
    function registerProperty(string memory _name) public returns(uint256){
        uint256 propertyId = totalProperties + 1;
        IntellectualProperty storage property = intellectualProperties[propertyId];
        property.owner = msg.sender;
        property.name = _name;
        property.registrationDate = block.timestamp;
        
        totalProperties++;
        
        emit PropertyRegistered(propertyId, msg.sender, _name, block.timestamp);
        return(propertyId);
    }
    
    function transferProperty(uint256 _propertyId, address _newOwner) public {
        require(_propertyId > 0 && _propertyId <= totalProperties, "Invalid property ID");
        IntellectualProperty storage property = intellectualProperties[_propertyId];
        require(msg.sender == property.owner, "Only the owner can transfer the property");
        
        address previousOwner = property.owner;
        property.owner = _newOwner;
        
        emit PropertyTransferred(_propertyId, previousOwner, _newOwner, block.timestamp);
    }
    
    function getProperty(uint256 _propertyId) public view returns (address owner, string memory name, uint256 registrationDate) {
        require(_propertyId > 0 && _propertyId <= totalProperties, "Invalid property ID");
        IntellectualProperty storage property = intellectualProperties[_propertyId];
        
        owner = property.owner;
        name = property.name;
        registrationDate = property.registrationDate;
    }
}
