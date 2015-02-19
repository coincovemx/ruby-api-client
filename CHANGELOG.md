
# Change Log
You can see the supported releases on the [project GitHub repository](http://https://github.com/coincovemx/ruby-api-client/releases).

## To Do
- Add specs.
- Add proper docs.
- Automatics test suite run. (Codeship)

## Unreleased
### Added
- No recent changes.

## v1.1.0
### Added
- Better token handling with `tokens`, `request_tokens`, `ùse_tokens` and `refresh_tokens` available from the client public methods.
- Aliases for the methods with name changes.
- `send_money` (`send_funds`) method replaces the `send` method to avoid the clash with the `Òbject#send` method.
- ArgumentError exceptions for params on methods that use them to build the resource URL.

### Removed
- `send` method. Use `send_money` method from now on.

## v1.0.0
### Added
- OAuth2 integration.
- Exchange rates wrappers.
- Users wrappers.
- Transactions wrappers.
- Slips wrappers.
- Merchants wrappers.
