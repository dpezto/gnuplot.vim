# Contributing

Thanks for helping out. Small, focused PRs merge fastest.

## Where a change belongs

`syntax/gnuplot.vim` has two halves. Everything between the generated markers
comes from `keywords.json` and must not be hand edited — CI fails if the
committed block does not match what the generator produces. Everything outside
the markers (comments, strings, numbers, operators, control-flow words, the
highlight links) is hand maintained and edited directly.

To add or correct a keyword, fix it upstream in
[tree-sitter-gnuplot](https://github.com/dpezto/tree-sitter-gnuplot), copy the
refreshed `keywords.json` here, and regenerate. Keeping the two in step is the
point of the arrangement; patching the generated block locally defeats it.

## Development

```sh
npm run gen:syntax                          # regenerate from keywords.json
npm run check:syntax                        # what CI runs
nvim --headless -u NONE -S tests/run.vim    # assertions
vim  -es      -u NONE -S tests/run.vim      # same, under Vim
```

`tests/run.vim` uses Vim's own `assert_*` functions and exits non-zero if
anything lands in `v:errors`. Add a case for any behaviour a change could
break. The assertions read the raw syntax group under a given word rather than
the translated highlight group, because Vim collapses `Conditional`, `Repeat`
and `Keyword` into `Statement`, which would make most of them vacuous.

Verify claims about what gnuplot accepts against a real gnuplot, and check by
resolution rather than acceptance: gnuplot takes an ambiguous abbreviation and
silently resolves it to whichever entry comes first in its own table, so
`set encoding iso` succeeding does not mean `iso` names the encoding you meant.

## Commits and PR titles

PRs are squash-merged and releases are cut by
[release-please](https://github.com/googleapis/release-please) from the commit
history, so **PR titles must follow
[Conventional Commits](https://www.conventionalcommits.org)** (`feat: …`,
`fix: …`, `docs: …`). CI checks the title; `feat` and `fix` decide the version
bump and the CHANGELOG entry, and a `!` suffix or a `BREAKING CHANGE:` footer
forces a major.

Do **not** hand-edit versions. release-please owns `version.txt`,
`CHANGELOG.md` and the `version` and `date-released` fields of `CITATION.cff` —
the latter two through the `# x-release-please-version` and
`# x-release-please-date` markers on those lines. A file that is not listed
under `extra-files` in `.release-please-config.json` is silently never updated,
which is how a CITATION.cff goes stale without anyone noticing.

## AI-assisted contributions

AI assistance (Copilot, Claude, etc.) is welcome, with three rules:

1. **Disclose it** in the PR description (a one-liner is fine).
2. **You must understand and have tested the change yourself** — run the
   assertions locally. You are the author; "the model wrote it" is not a review
   response.
3. **No unreviewed dumps.** Large AI-generated diffs with no accompanying
   reasoning, and AI-generated bug reports without a reproducible snippet, will
   be closed.

## Bug reports

A minimal gnuplot snippet (confirmed accepted by `gnuplot` itself) plus what
you expected the highlighting to be turns a week of back-and-forth into a
same-day fix.
