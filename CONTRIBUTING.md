# Contributing

## Branch Naming

```
feat/your-feature-name
fix/what-you-are-fixing
docs/page-or-section-name
refactor/scope-of-change
test/what-is-being-tested
```

## Commit Message Format

Conventional Commits, one logical change per commit:

```
type(scope): short description in lowercase
```

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `chore`.

Examples:
```
feat(contract): add early withdrawal with penalty flag
fix(deposit): correct overflow guard on checked_add
test(withdraw): add double withdrawal failure case
```

## Pull Request Process

1. Fork and branch off `main` using the naming rules above.
2. Run `cargo test` and confirm all tests pass before opening the PR.
3. Open a PR against `main`, referencing the issue it addresses.
4. Push follow-up changes to the same branch rather than opening a new PR.

## Ideas for Contribution

- **Keeper script** — a small script that polls for goals past their deadline and calls `check_deadline` on them. See `fundkeep-app/docs/concepts/deadline-unlock.md`.
- **Early withdrawal with penalty** — a v2 feature letting an owner exit a LOCKED goal early at the cost of forfeiting a percentage of saved funds.
- **Multi-user / group goals** — shared goals where multiple wallets deposit, with ownership split proportionally.
