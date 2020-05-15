.PHONY: buildConfig


git:
	git add .
	git commit -m "$m"
	git push


history:
	cp ~/.bash_history proto_assemble


buildConfig:
	python /projects/ancestor/buildConfig/generate_buildConfig.py > buildConfig.yaml


preparations:
	yes | conda create --prefix ./envs -c conda-forge jinja2 PyYAML
	echo "env_prompt: '(ancestor) '" > ./envs/.condarc

