#!/usr/bin/env python3
import yaml
from mako.template import Template
import sys

variables={}
with open("variables.yml", 'r') as stream:
    try:
        variables=yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)
        sys.exit(1)

rendered_str=Template(filename='query-spending.sql.tmpl',
                    strict_undefined=True).render(**variables)

with open('query-spending.sql','w') as f:
    f.write(rendered_str)

