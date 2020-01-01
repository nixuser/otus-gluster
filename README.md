# otus-gluster

# GlusterFS Distributed Filesystem Configuration

Создание файловой системы [GlusterFS](http://www.gluster.org/) на двух серверах

##  Создание виртуальной машины

  1. Скачать и установить [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
  2. Скачать и установить [Vagrant](http://www.vagrantup.com/downloads.html).
  3. [Mac/Linux only] Установить [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html).
  4. Установить роли ansible `ansible-galaxy install -r requirements.yml` 
  5. Запускаем `vagrant up` чтобы создать виртуальные машины и запустить конфигурацию

## Проверить что Gluster работает правильно следующими командами

    # Получить статус кластера. 
    $ ansible gluster -i inventory -a "gluster peer status" -b
    
    # Получить состояние тома (volume) кластера.
    ansible gluster -i inventory -a "gluster volume info" -b

Можно убедиться, что файлы реплицируются / распространяются правильно:

 1. Войдите на первый сервер: `vagrant ssh gluster1`
 2. Создайте файл в подключенном томе кластера: `sudo touch /mnt/gluster/test`
 3. Выйдите из первого сервера: `exit`
 4. Войдите на второй сервер: `vagrant ssh gluster2`
 5. Просмотрите содержимое каталога gluster: `ls /mnt/gluster`

Вы должны увидеть файл `test`, созданный на шаге 2; это означает, что Gluster работает правильно!

## Источники:
Проект использует роли из [Jeff Geerling](https://www.jeffgeerling.com/) as an example for [Ansible for DevOps](https://www.ansiblefordevops.com/).
