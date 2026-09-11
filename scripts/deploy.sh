#!/usr/bin/env bash
# Builds and deploys the FundKeep contract to Stellar Testnet, in order.
#
# Prerequisites:
#   - stellar-cli installed (`cargo install --locked stellar-cli` or a
#     prebuilt release from https://github.com/stellar/stellar-cli/releases)
#   - A funded testnet identity. Create one with:
#       stellar keys generate deployer --network testnet --fund
#
# Usage:
#   ./scripts/deploy.sh [SOURCE_IDENTITY]
#
# SOURCE_IDENTITY defaults to "deployer".

set -euo pipefail

SOURCE="${1:-deployer}"
NETWORK="testnet"

echo "==> Building contract (wasm32v1-none, release)"
cargo build --target wasm32v1-none --release --package fundkeep-contract

WASM_PATH="target/wasm32v1-none/release/fundkeep_contract.wasm"

if [ ! -f "$WASM_PATH" ]; then
  echo "Build did not produce $WASM_PATH" >&2
  exit 1
fi

echo "==> Deploying to $NETWORK using identity '$SOURCE'"
CONTRACT_ID=$(stellar contract deploy \
  --wasm "$WASM_PATH" \
  --source "$SOURCE" \
  --network "$NETWORK")

cat <<EOF

==============================================
FundKeep contract deployed.

  NEXT_PUBLIC_CONTRACT_ID=$CONTRACT_ID
  NEXT_PUBLIC_STELLAR_NETWORK=testnet
  NEXT_PUBLIC_SOROBAN_RPC_URL=https://soroban-testnet.stellar.org

Before wiring in NEXT_PUBLIC_USDC_CONTRACT_ID, verify the testnet USDC SAC
address is still live — addresses on testnet can go stale:

  stellar contract info interface \\
    --id CDLZFC3SYJYDVR72W5SCVNVV45XMCHZDBNDVLYZ2G7SFKNEPFBYSYTRU \\
    --network testnet

If that fails, find a current testnet USDC SAC (or issue your own test asset
and wrap it with `stellar contract asset deploy`) before continuing.

Copy the values above into:
  - fundkeep-app/.env.local
  - fundkeep-indexer/.env
==============================================
EOF
