FROM python:3.13.2-alpine

RUN apk add --update --no-cache git make
RUN git config --global init.defaultBranch main
RUN pip install --no-cache-dir jinja2_time cookiecutter

ADD . /cookiecutter/template

ENTRYPOINT [ "cookiecutter", "--output-dir", "/cookiecutter/app", "/cookiecutter/template" ]