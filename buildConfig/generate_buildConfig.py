import os
dirname = os.path.dirname(
    os.path.abspath(
        __file__
    )
)
settings_file_name = os.path.join(dirname, "settings.yaml")
template_file_name = os.path.join(dirname, 'ancestor-buildconfig-template.yaml')


#Import necessary functions from Jinja2 module
from jinja2 import Environment, FileSystemLoader

#Import YAML module
import yaml

#Load data from YAML into Python dictionary
config_data = yaml.load(open(settings_file_name))
# print(config_data)


#Load Jinja2 template
env = Environment(loader = FileSystemLoader('/'), trim_blocks=True, lstrip_blocks=True)

def path_join(path_components):
    return os.path.join(*path_components)
    
env.filters['path_join']=path_join

template = env.get_template(template_file_name)
# print(template)


#Render the template with data and print the output
print(template.render(config_data))