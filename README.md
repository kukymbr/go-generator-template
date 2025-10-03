# The Golang code generator app template

This is a [🍪 `cookiecutter` ✂️](https://cookiecutter.readthedocs.io) template for a Golang code generator app project.

## Creating a new project

First, clone this repository and change into its directory:

```shell
git clone https://github.com/kukymbr/go-generator-template.git
cd go-generator-template
```

### `create.sh`

The [create.sh](create.sh) file is a script to create a new project using the skeleton template.
Docker engine is required.

```text
Usage: create.sh <project_name> [--target=<target_dir>] [--tag=<image_tag>] [EXTRA_ARGS]

  project_name: name of the project to generate, required
  --target: path to the target projects' dir, default is "./gen"
  --tag: docker image tag to build with, default is "apisrv_skeleton_cookiecutter"
  EXTRA_ARGS: additional arguments to pass to the cookiecutter
```

You are free to run this script without any cookiecutter arguments; 
in this case, the interactive mode of the cookiecutter will be executed:

```shell
./create.sh your_app_fancy_name
```

To run cookiecutter in non-interactive mode,
pass `--no-input` argument and template values to override to the EXTRA_ARGS, for example:

```shell
./create.sh your_app_fancy_name --no-input with_vt=False
```

### Local installation

The `create.sh` script uses Docker images to run cookiecutter. 
If you want to avoid the Docker usage, install the cookiecutter locally. 

Follow the [official documentation](https://cookiecutter.readthedocs.io/en/stable/installation.html) steps 
to install a cookiecutter, then run it against this dir. 
The `__project_name` is a mandatory argument:  

```shell
# Running in interactive mode:
cookiecutter --verbose --output-dir ~/path/to/projects/dir __project_name=testapp .

# Running in non-interactive mode with specified template values:
cookiecutter --verbose --output-dir ~/path/to/projects/dir --no-input __project_name=testapp with_vt=False . 
```

In the case of the local cookiecutter execution, 
the `postintall.sh` script is needed to be executed when project dir is ready:

```shell
cd ~/path/to/projects/dir/testapp 
./postintall.sh
```

It could be deleted after the execution.

### Available template options

See the [cookiecutter.json](cookiecutter.json) for available options.