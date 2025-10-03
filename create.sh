#!/usr/bin/env bash

project_name=""
target_project_dir=""
target_dir="./gen"
image_tag="gogenerator_skeleton_cookiecutter"
extra_args=()
no_input=0
overwrite_dir=0

echo "👋 Hi, this is a script to create new Golang code generator project."

print_usage() {
  cat << EOF

Usage: create.sh <project_name> [--target=<target_dir>] [--tag=<image_tag>] [EXTRA_ARGS]

  project_name: name of the project to generate, required
  --target: path to the target projects' dir, default is "./gen"
  --tag: docker image tag to build with, default is "skeleton_cookiecutter"
  EXTRA_ARGS: additional arguments to pass to the cookiecutter

You are free to run this script without any cookiecutter arguments.
In this case, the interactive mode of the cookiecutter will be executed.

To run cookiecutter in non-interactive mode,
pass --no-input argument and template values to override to the EXTRA_ARGS, for example:

  ./create.sh your_app_fancy_name --no-input with_restful=False
EOF
}

err() {
  echo "😢 ERROR: $@" >&2
}

warn() {
  echo "⚠️ WARNING: $@" >&2
}

info() {
  echo "ℹ️ $@"
}

debug() {
  echo "⚙️ $@"
}

fail() {
  if [ $# -gt 0 ]; then
    err "$@"
  fi
  info "Run './create.sh --help' for usage."

  exit 1
}

fail_with_usage() {
  if [ $# -gt 0 ]; then
    err "$@"
  fi

  print_usage

  exit 1
}

prompt_confirm() {
  while true; do
    read -r -p "🤔 ${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid input"
    esac
  done
}

parse_args() {
  for i in "$@"; do
    case $i in
      -h|--help)
        print_usage
        exit 0
        ;;
      --target=*)
        target_dir="${i#*=}"
        shift
        ;;
      --tag=*)
        image_tag="${i#*=}"
        shift
        ;;
      --no-input)
        extra_args+=("$1")
        no_input=1
        shift
        ;;
      --overwrite-if-exists)
        extra_args+=("$1")
        overwrite_dir=1
        shift
        ;;
      *)
        if [ -z "$project_name" ]; then
          project_name="$1"
          extra_args+=("__project_name=$1")
        else
          extra_args+=("$1")
        fi
        shift
        ;;
    esac
  done

  target_project_dir="$target_dir/$project_name"

  if [ -z "$project_name" ]; then
    fail_with_usage "project_name argument is missing"
  fi

  if [ -d "$target_project_dir" ]; then
    if [ "$no_input" == "0" ] && [ "$overwrite_dir" == "0" ]; then
      warn "Directory $target_project_dir already exists."

      prompt_confirm "Do you want to rewrite it?"
      if [ $? -eq 0 ]; then
        new_extra_args=()
        new_extra_args+=("--overwrite-if-exists")
        new_extra_args+=(${extra_args[@]})
        extra_args=()
        extra_args+=(${new_extra_args[@]})
      else
        fail "Directory $target_project_dir already exists and not allowed to be rewritten."
      fi
    fi
  fi

  debug "project_name=$project_name"
  debug "target_dir=$target_dir"
  debug "target_project_dir=$target_project_dir"
  debug "image_tag=$image_tag"
  debug "extra_args=${extra_args[*]}"
}

post_install() {
  if [ -O "$target_project_dir" ]; then
    debug "Target project dir owned by the current user."
  else
    debug "Target project dir is not owned by the current user, trying to change..."

    sudo chown -R $(whoami) "$target_project_dir"
  fi

  debug "Running the post-install script..."
  orig_dir=$(pwd)
  cd "$target_project_dir"
  ./postinstall.sh
  rm -f ./postinstall.sh
  cd "$orig_dir"
}

parse_args "$@"

if [ "$no_input" == "0" ]; then
  interactive="1"
fi

debug "Building an image..."
docker build -t "$image_tag" -f Dockerfile . || fail "Failed to build image"

debug "Running the cookiecutter..."
docker run --rm ${interactive:+"-it"} --volume="$target_dir":/cookiecutter/app "$image_tag" ${extra_args[*]} || fail "Failed to run image"

info "Project is successfully generated"

post_install

echo "👍 All done."