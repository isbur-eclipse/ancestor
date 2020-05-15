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
	conda env config vars set CONDA_PROMPT_MODIFIER='(ancestor) ' -p ./envs
	# conda config --set env_prompt '"(ancestor) "' --file ./envs/.condarc
	# echo "env_prompt: '(ancestor) '" > ./envs/.condarc
	# conda env config vars set env_prompt='(ancestor) ' -p ./envs
	# conda env config vars set CONDA_ENV_PROMPT='(ancestor) ' -p ./envs
	# conda env config vars list
	# conda config --set env_prompt '(ancestor) '
	# conda config --set env_prompt '(ancestor) ' --env
	# conda config --set env_prompt '({default_env}) '
