# Race Condition in Ownable Contract
This example demonstrates a race condition vulnerability in a Solidity smart contract's ownership transfer function.  The current implementation lacks the necessary locking mechanism to prevent concurrent ownership changes from overriding each other.

## Vulnerability
The `transferOwnership` function does not employ a mutex or other concurrency control.  Multiple transactions calling this function simultaneously may result in unpredictable ownership assignments; only the last transaction successfully executed determines the final owner.

## Mitigation
The solution provides a way to prevent this race condition by implementing a reentrancy guard.