#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>

#define BACKLOG 2

int main(int argc, const char *argv[])
{
	char ch;
	int sockfd;
	int new_fd;
	struct sockaddr_un srv_addr;
	struct sockaddr_un client_addr;

	/* delete the socket file */
	unlink("server_socket");

	/* create a socket */
	sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
	if (sockfd == -1) {
		printf("[server] socket failed:%d", errno);
		return -1;
	}

	srv_addr.sun_family = AF_UNIX;
	strcpy(srv_addr.sun_path, "server_socket");

	/* bind with the local file */
	if (bind(sockfd, (struct sockaddr *)&srv_addr, sizeof(srv_addr)) < 0) {
		printf("[server] bind error\n");
		return -1;
	}

	/* listen */
	listen(sockfd, BACKLOG);

	socklen_t len = sizeof(client_addr);
	while (1) {
		printf("[server] waiting:\n");

		/* accept a connection */
		new_fd = accept(sockfd, (struct sockaddr *)&client_addr, &len);
		if (new_fd == -1) {
			printf("[server] receive failed\n");
		} else {
			printf("[server] receive success\n");
			/* exchange data */
			read(new_fd, &ch, 1);
			printf("[server] get char from client: %c\n", ch);
			++ch;
			write(new_fd, &ch, 1);
		}
		/* close the * socket */
		close(new_fd);
	}

	return 0;
}
