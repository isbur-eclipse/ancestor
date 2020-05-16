.PHONY: buildConfig


git:
	git add --all .
	git commit -m "$m"
	git push


galushka:
	oc create -f buildConfig.yaml


subgalushka:
	./make/subgalushka.sh


history:
	cp ~/.bash_history proto_assemble


login:
	echo "export OPENSHIFT_SERVER_URL=https://api.us-east-1.starter.openshift-online.com:6443" >> ~/.bashrc
	oc login --token=$$OPENSHIFT_LOGIN_TOKEN --server=$$OPENSHIFT_SERVER_URL


settings:
	printf "galushka_name: $$GALUSHKA_NAME\n\
openshift_workspace_name: $$OPENSHIFT_WORKSPACE_NAME\n\
output_docker_repo_url: $$OUTPUT_DOCKER_REPO_URL\n\
docker_tagname: $$DOCKER_TAGNAME\n\
base_dockerimage: $$BASE_DOCKERIMAGE\n\
source_git_repo_url: $$SOURCE_GIT_REPO_URL\n\
OPENSHIFT_SERVER_URL: $$OPENSHIFT_SERVER_URL\
" > ./buildConfig/settings.yaml

buildConfig:
	python /projects/ancestor/buildConfig/generate_buildConfig.py > buildConfig.yaml


preparations:
	# wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz
	# mkdir /home/user/bin
	# tar -C /home/user/bin -zxvf openshift-client-linux.tar.gz
	echo "export PATH=$$PATH:/home/user/bin" >> ~/.bashrc

# buildConfig preparations
#preparations:
#	yes | conda create --prefix ./envs -c conda-forge jinja2 PyYAML
#	echo "env_prompt: '(ancestor) '" > ./envs/.condarc

