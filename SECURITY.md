# Security Policy

## Audit Status

This contract has **not** been professionally audited. Use on Testnet only until an audit has been completed. Do not deploy to Mainnet with real funds based on this codebase alone.

## Scope

This policy covers the Soroban contract in `contracts/fundkeep`. It does not cover the frontend, SDK, or indexer repos, which have their own `SECURITY.md`.

## Reporting a Vulnerability

If you find a security issue — a way to bypass the deposit lock, double-withdraw, drain funds, or otherwise violate the invariants described in `fundkeep-app/docs/contract/security.md` — please report it privately rather than opening a public issue.

Contact: open a private security advisory on this repository (GitHub → Security → Report a vulnerability), or reach the maintainer directly via the contact listed in `fundkeep-app`'s README.

Please include:
- A description of the issue and its impact
- Steps to reproduce (a failing test case is ideal)
- Any suggested fix, if you have one

We aim to acknowledge reports within a few days.
