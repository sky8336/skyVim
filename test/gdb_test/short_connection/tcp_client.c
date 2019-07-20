#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>

#define DEBUG_INFO "[client]"

int main(int argc, const char *argv[])
{
	/* create a socket */
	int sockfd;
	struct sockaddr_un address;

	sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
	if (sockfd == -1) {
		printf(DEBUG_INFO " socket failed:%d", errno);
		return -1;
	}

	address.sun_family = AF_UNIX;
	strcpy(address.sun_path, "server_socket");

	/* connect to the server */
	int result = connect(sockfd, (struct sockaddr *)&address, sizeof(address));
	if (result == -1) {
		perror(DEBUG_INFO " connect failed: ");
		exit(1);
	}

	/* exchange data */
	char ch = 'A';
	write(sockfd, &ch, 1);
	read(sockfd, &ch, 1);
	printf(DEBUG_INFO "get char from server: %c\n", ch);

	while (1)
		usleep(1000*1000);
	/* close the socket */
	close(sockfd);

	return 0;
}
