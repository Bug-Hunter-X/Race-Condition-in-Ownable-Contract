function transferOwnership(newOwner) {
  require(newOwner != address(0), "Ownable: new owner is the zero address");
  require(_owner == msg.sender, "Ownable: caller is not the owner"); //Added this line
  _transferOwnership(newOwner); // Transfer function will handle the update and lock
}

function _transferOwnership(newOwner) {
  bool _success = false;
  assembly {
    let ptr := mload(0x40)
    mstore(ptr, 0x20)
    mstore(add(ptr, 0x20), 0x0000000000000000000000000000000000000000000000000000000000000000) //owner
    mstore(add(ptr, 0x40), 0x20)
    mstore(add(ptr, 0x60), newOwner) //newOwner
    mstore(0x40, add(ptr, 0x80)) //memory pointer
    _success := staticcall(gas(), 7, ptr, 0x80, 0x0, 0x0) //Call the owner modifier
  }
  require(_success, "Ownable: update failed");
  emit OwnershipTransferred(_owner, newOwner);
  _owner = newOwner;
}
modifier onlyOwner() {
  require(_owner == msg.sender, "Ownable: caller is not the owner");
  _;
}