# Security Policy

## Reporting a Vulnerability

Please report security vulnerabilities privately via
[GitHub's private vulnerability reporting](https://github.com/dpezto/gnuplot.vim/security/advisories/new)
rather than filing a public issue.

This is a parser grammar (no server component, no runtime secrets). The main
risk surface is:

- The external scanner (`src/scanner.c`): a crafted input causing out-of-bounds
  reads / unbounded memory during parsing in an embedding editor.
- Supply-chain issues in CI (GitHub Actions dependencies).

Expect an initial response within a few days; this is a solo-maintained project.
