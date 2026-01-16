# pact_consumer_ex

`pact_consumer_ex` is an Elixir library that provides Native Implemented Function (NIF) bindings to the [`pact_consumer`](https://github.com/pact-foundation/pact-reference/tree/master/rust/pact_consumer) Rust library. It leverages [Rustler](https://github.com/rusterlium/rustler) to expose the Rust functions while maintaining the same look and feel as the original library.

## Installation

Add to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:pact_consumer_ex, "~> 0.2.0", only: [:test]}
  ]
end
```

Then run:

```bash
mix deps.get
```

## Usage

For example usage of the library, refer to the [`test/pact_builder_test.exs`](test/pact_builder_test.exs) file, which contains practical examples demonstrating how to utilize the exposed NIF functions.

## Configuration

This library uses the same environment variables as the Rust `pact_consumer` library ([Pact test DSL for writing consumer pact tests in Rust - Pact Docs](https://docs.pact.io/implementation_guides/rust/pact_consumer)):

- **Changing the output directory**:  
  By default, the pact files will be written to `target/pacts`. To change this, set the environment variable `PACT_OUTPUT_DIR`. 

- **Forcing pact files to be overwritten**:  
  Pacts are merged with existing pact files when written. To change this behaviour so that the files are always overwritten, set the environment variable `PACT_OVERWRITE` to `true`.

## Pact Plugins

To use a plugin, install it with the [`pact-plugin-cli`](https://github.com/pact-foundation/pact-plugins/releases?q=pact+plugin+cli&expanded=true). By default, plugins are installed under `~/.pact/plugins/`. You can change this location by setting the `PACT_PLUGIN_DIR` environment variable.

See an example plugin usage in [`test/pact_builder_test.exs`](test/pact_builder_test.exs).

For more information about plugins, refer to the [Pact plugin quick start guide](https://docs.pact.io/plugins/quick_start).

## Current Status

Currently, `pact_consumer_ex` supports:

- Synchronous HTTP interactions.
- Asynchronous message interactions.
- Integration with Pact plugins.

Planned future enhancements include:

- Support for synchronous message interactions.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

