# ancestor

## Dependencies
git
conda
python
pypandoc
python-docx
openshift-cli
djinja2 (?)

## Assembly

0. За основу взят образ:

https://quay.io/eclipse/che-cpp-rhel7

который, в свою очередь, основан на

registry.access.redhat.com/devtools/llvm-toolset-rhel7

(ключевой момент - RHEL, простым смертным его не достать, но можно почитать описание:

https://access.redhat.com/documentation/en-us/red_hat_developer_tools/2018.2/html-single/using_clang_and_llvm_toolset/index

)

1. Файлы из этого репозитория, расположенные в папке .s2i/bin, используются для модификации этого образа на сервере Openshift Online Start

2. В соответствии с документацией s2i, сначала запускается скрипт assemble - этакий dockerfile, но от лица non-root пользователя
    1. Собственно, настраивается git, используются данные из моего Openshift Online аккаунта (доступны через заранее заданные переменные окружения)
    2. Скачивается и устанавливается Miniconda с префиксом /home/user/miniconda
    3. Проводятся некие манипуляции с правами доступа (не уверен, что достаточные)
    4. О, а ещё в конце используется какой-то гит-репозиторий для загрузки логов (видимо, ветка :logs этого репозитория)

3. Наконец, в командах скрипта run (эквивалентен RUN докерфайла) активируется conda-окружение

4. Выходной образ:

https://hub.docker.com/repository/docker/isbur/ancestor
