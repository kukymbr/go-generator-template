# {{ cookiecutter.__project_name }}

The `{{ cookiecutter.__project_name }}` is a code generator for the [Golang](https://go.dev).

{{ cookiecutter.project_description }}

## Why?

## Installation

The go {{ cookiecutter.go_version }} is a minimal requirement for the `{{ cookiecutter.__project_name }}`. 

The `go tool` is a preferred way to install:

```shell
go get -tool {{ cookiecutter.module_name }}/cmd/sqlamble@latest
```

## Usage

The `{{ cookiecutter.__project_name }} --help` output:

```text
Usage:
  {{ cookiecutter.__project_name }} [flags]

Flags:
      --fmt string            Formatter used to format generated go files (gofmt|noop) (default "gofmt")
  -h, --help                  help for {{ cookiecutter.__project_name }}
      --package string        Target package name of the generated code 
  -s, --silent                Silent mode
      --target string         Directory for the generated Go files (default ".")
  -v, --version               version for {{ cookiecutter.__project_name }}
```

1. ...
2. Add the go file with a `//go:generate` directive:
   ```go
    package sql  

   //go:generate go tool {{ cookiecutter.__project_name }} --package=mypkg
   ```
3. Run the `go generate` command:
   ```shell
   go generate ./...
   ```
4. ...

See the [example](example) directory for usage and generated code example.

## Contributing

Please refer the [CONTRIBUTING.md](CONTRIBUTING.md) doc.

## License

[MIT](LICENSE).