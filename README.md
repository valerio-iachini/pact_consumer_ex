# pact_consumer_ex

`pact_consumer_ex` is an Elixir library that provides Native Implemented Function (NIF) bindings to the [`pact_consumer`](https://github.com/pact-foundation/pact-reference/tree/master/rust/pact_consumer) Rust library. It leverages [Rustler](https://github.com/rusterlium/rustler) to expose the Rust functions while maintaining the same look and feel as the original library.

## Installation

Add to your `mix.exs` dependencies:

```elixir
def deps do
  [
    {:pact_consumer_ex, "~> 0.1.0"}
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

## Current Status

Currently, `pact_consumer_ex` supports:

- Synchronous HTTP interactions.
- Asynchronous message interactions.

Planned future enhancements include:

- Support for synchronous message interactions.
- Integration with Pact plugins.

## Contributing

Contributions are welcome! Please open issues or submit pull requests for any enhancements or bug fixes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

