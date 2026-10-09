# fundkeep-contract

The Soroban smart contract behind [FundKeep](https://github.com/fundkeep-web/fundkeep-app) — a non-custodial savings-goal contract on Stellar. One deployment handles every user and every goal; goals are differentiated by an auto-incrementing `goal_id`.

A goal locks a target amount of a token (USDC on testnet) until either the target is reached or a deadline passes. There is no early withdrawal and no admin override — enforcement is entirely on-chain. See [`fundkeep-app/docs/contract`](https://github.com/fundkeep-web/fundkeep-app/tree/main/docs/contract) for the full spec this implementation follows.

**Verified Testnet deployment:** [`CBYUM...DDFAH`](https://stellar.expert/explorer/testnet/contract/CBYUMUNDBGT5JTYX62SSFH5NTK2ELLRT2PP3LLZOI757JB4BULDDDFAH) · [deployment manifest](deployments/testnet.json) · [live app](https://fundkeep.vercel.app) · [documentation](https://entity-6.gitbook.io/fundkeep)

> The contract is unaudited and must not be used with Mainnet funds.

## Repo Layout

```
contracts/fundkeep/
  src/
    lib.rs      # contract entry points: create_goal, deposit, check_deadline, withdraw, get_goal
    types.rs    # SavingsGoal, DataKey
    errors.rs   # contract error codes
    events.rs   # contractevent definitions (goal_created, deposit, unlock, withdraw)
    test.rs     # unit test suite
scripts/deploy.sh
```

## Requirements

- Rust (stable), with the `wasm32v1-none` target: `rustup target add wasm32v1-none`
- [stellar-cli](https://github.com/stellar/stellar-cli) for deployment

## Build & Test

```bash
cargo test
cargo build --target wasm32v1-none --release
```

## Deploy to Testnet

```bash
stellar keys generate deployer --network testnet --fund
./scripts/deploy.sh deployer
```

The script builds, deploys, and prints the resulting contract ID and Testnet RPC settings. Configure a verified token SAC separately before setting `NEXT_PUBLIC_USDC_CONTRACT_ID` in `fundkeep-app`.

The public submission deployment is recorded in [`deployments/testnet.json`](deployments/testnet.json). Do not replace its identifiers without verifying the new deployment on-chain and updating the app, indexer, SDK documentation and release notes together.

## Contract Interface

| Function | Auth | Description |
|---|---|---|
| `create_goal(owner, token, target_amount, deadline) -> u32` | `owner` | Creates a goal, returns its ID |
| `deposit(caller, goal_id, amount)` | `caller` (must be owner) | Adds funds; auto-unlocks if target reached |
| `check_deadline(goal_id)` | none | Unlocks the goal if its deadline has passed |
| `withdraw(caller, goal_id)` | `caller` (must be owner) | Pays out the full balance once unlocked |
| `get_goal(goal_id) -> SavingsGoal` | none | Reads a goal's state |

Errors: `GoalNotFound`, `NotUnlocked`, `AlreadyWithdrawn`, `Unauthorized`, `InvalidAmount`, `InvalidDeadline`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Security issues: see [SECURITY.md](SECURITY.md).
