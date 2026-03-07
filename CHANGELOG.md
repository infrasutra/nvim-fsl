# Changelog

All notable changes to this project are documented in this file.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-03-06

### Added

- Block comment (`/* */`) syntax highlighting
- Optional (`?`) and enum assignment (`=`) operator highlighting
- Array bracket (`[Type]`) highlighting
- `ftplugin/fsl.vim` with sensible defaults (2-space indent, commentstring, foldmethod)
- `after/ftplugin/fsl.vim` with auto-closing pairs for `{}`, `[]`, `()`
- 21 LuaSnip snippets (`snippets/fsl.lua`) matching VS Code extension
- `:FslValidate` user command to validate workspace schemas
- `:FslRestartLSP` user command to restart the language server
- LSP binary existence check before server registration
- Snippet integration documentation in README

### Fixed

- CI workflow uses `actions/checkout@v4` (was @v6 which doesn't exist)
- CI now validates both Lua and Vim script files
- Removed dead `fslRequired` highlight rule

## [0.1.0] - 2026-03-04

### Added

- Initial public release of Neovim syntax and LSP integration for FSL.
