git:
	git add .
	git commit -m "$m"
	git push


history:
	cp ~/.bash_history proto_assemble


buildConfig:
	python ./buildConfig/generate_buildConfig.py
