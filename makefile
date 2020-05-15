git:
	git add .
	git commit -m "$m"
	git push


history:
	cp ~/.bash_history proto_assemble


buildConfig:
	python ./buildConfig/generate_buildConfig.py


preparations:
	yes | conda create --prefix ./envs -c conda-forge jinja2 PyYAML
	conda env config --set env_prompt '(ancestor)' -p ./envs
