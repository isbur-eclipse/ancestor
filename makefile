.PHONY: buildConfig


git:
	git add .
	git commit -m "$m"
	git push


galushka:
	oc create -f buildConfig.yaml


history:
	cp ~/.bash_history proto_assemble


login:
	echo "export OPENSHIFT_SERVER_URL=https://api.us-east-1.starter.openshift-online.com:6443" >> ~/.bashrc
	oc login --token=$$OPENSHIFT_LOGIN_TOKEN --server=$$OPENSHIFT_SERVER_URL


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

