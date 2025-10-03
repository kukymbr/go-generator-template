import os
import shutil
from subprocess import Popen

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

def remove_file(filename):
    fullpath = os.path.join(PROJECT_DIRECTORY, filename)
    if os.path.exists(fullpath):
        os.remove(fullpath)

def remove_dir(dirname):
    shutil.rmtree(os.path.join(
        PROJECT_DIRECTORY, dirname
    ))

def remove_github_actions():
    """
    Removes GitHub actions
    """
    remove_dir(".github")

def remove_gitlab_ci():
    """
    Removes gitlab-ci
    """
    remove_dir(".gitlab")
    remove_file(".gitlab-ci.yml")

def init_git():
    """
    Initialises git on the new project folder
    """
    GIT_COMMANDS = [
        ["git", "init"],
        ["git", "config", "user.email", "{{ cookiecutter.author_email }}"],
        ["git", "config", "user.name", "{{ cookiecutter.author }}"],
        ["git", "add", "."],
        ["git", "commit", "-m", "Initial commit: generated with github.com/kukymbr/go-generator-template"],
    ]

    if "{{ cookiecutter.remote }}" != "-":
        GIT_COMMANDS.append(["git", "remote", "add", "origin", "{{ cookiecutter.remote }}"])

    for command in GIT_COMMANDS:
        cmd = Popen(command, cwd=PROJECT_DIRECTORY)
        cmd.wait()

if {{ cookiecutter.with_github_actions }} == False:
    remove_github_actions()

if {{ cookiecutter.with_gitlab_ci }} == False:
    remove_gitlab_ci()

init_git()

