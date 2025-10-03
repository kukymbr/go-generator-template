import re
import sys

PROJECT_NAME_REGEX = r'^[_a-zA-Z][_a-zA-Z0-9\-]+$'
__project_name = '{{ cookiecutter.__project_name }}'

if not re.match(PROJECT_NAME_REGEX, __project_name):
    print(f'😢 ERROR: "{__project_name}" is not a valid project name.')
    sys.exit(1)

print('🍪 Baking some cookies...')