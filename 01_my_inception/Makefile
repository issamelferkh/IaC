# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: obouykou <obouykou@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/10/19 16:10:45 by obouykou          #+#    #+#              #
#    Updated: 2021/10/28 13:01:16 by obouykou         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# to use docker without sudo privileges
# sudo setfacl -m user:"$USER":rw /var/run/docker.sock 

all:
	@mkdir /home/obouykou/data/wp /home/obouykou/data/db /home/obouykou/data/backup 2>/dev/null || true
	@sudo sed -i 's|localhost|obouykou.42.fr|' /etc/hosts || true
	@echo -e '\nBuilding images..\n'
	@docker-compose -f ./srcs/docker-compose.yml build 1>/dev/null
	@echo -e '\nStarting services..\n'
	@docker-compose -f ./srcs/docker-compose.yml up -d

build:
	@echo -e '\nBuilding images..\n'
	@docker-compose -f ./srcs/docker-compose.yml build 1>/dev/null

up:
	@docker-compose -f ./srcs/docker-compose.yml up -d
	

stop:
	@echo 'stopping all services'
	@docker-compose -f ./srcs/docker-compose.yml down

vclean: # remove wordpress and mariadb volumes
	@echo 'cleaning wordpress and mariadb volumes on host machine'
	@sudo /bin/rm -rf /home/obouykou/data/wp/*
	@sudo /bin/rm -rf /home/obouykou/data/db/*
	@sudo /bin/rm -rf /home/obouykou/data/backup/*

dclean:
	@echo 'cleaning all images and containers'
	@docker system prune -a

logs:
	@docker-compose -f ./srcs/docker-compose.yml logs

re: stop all
	
