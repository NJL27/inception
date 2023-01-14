# 'docker-compose.yml up' builds all containers for LEMP stack
all:
	mkdir -p /home/nlenoch/data/wordpress_database
	mkdir -p /home/nlenoch/data/wordpress_files
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

# 'docker=compose.yml down' stops all containers for LEMP stack
clean:
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

# '--volumes -rmi all' removes all named volumes in the Compose file `volumes` section
# & all anonymous volumes attached to containers & all images belonging to the LEMP stack
# 'sudo rm -rf' deletes all database & wordpress files volumes on the host VM
fclean:
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down --volumes --rmi all
	sudo rm -rf /home/nlenoch/data/wordpress_database
	sudo rm -rf /home/nlenoch/data/wordpress_files

# clean everything & rebuild it
re: fclean all

# avoid conflicts with files of the same name & improve performance
.PHONY:
	all clean fclean re

# if error occures try this https://askubuntu.com/questions/1096930/sudo-apt-update-error-release-file-is-not-yet-valid