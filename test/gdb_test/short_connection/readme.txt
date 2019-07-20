以AF_UNIX方式进行通信的，这种方式是通过文件来将服务器和客户端连接起来的，
因此我们应该先运行tcp_server，创建这个文件，默认情况下，这个文件会创建在
当前目录下，并且第一个s表示它是一个socket文件

$ ll server_socket
srwxrwxr-x 1 chris chris 0 11月 15 14:30 server_socket=


======================================
 今天我们介绍如何编写Linux下的TCP程序，关于UDP程序可以参考这里：
 http://blog.csdn.net/htttw/article/details/7519971

 本文绝大部分是参考《Linux程序设计(第4版)》的第15章套接字


服务器端的步骤如下：
-------------------
1. socket：     建立一个socket
2. bind：       将这个socket绑定在某个文件上（AF_UNIX）或某个端口上（AF_INET），我们会分别介绍这两种。
3. listen：     开始监听
4. accept：     如果监听到客户端连接，则调用accept接收这个连接并同时新建一个socket来和客户进行通信
5. read/write： 读取或发送数据到客户端
6. close：      通信完成后关闭socket



客户端的步骤如下：
-----------------
1. socket：      建立一个socket
2. connect：   主动连接服务器端的某个文件（AF_UNIX）或某个端口（AF_INET）
3. read/write：如果服务器同意连接（accept），则读取或发送数据到服务器端
4. close：        通信完成后关闭socket




 上面是整个流程，我们先给出一个例子，具体分析会在之后给出。
 例子实现的功能是客户端发送一个字符到服务器，服务器将这个字符+1后送回客户端，客户端再把它打印出来：

=======================================
	1. 我们调用socket函数创建一个socket：
int socket(int domain, int type, int protocol)

	domain：指定socket所属的域，常用的是AF_UNIX或AF_INET
	AF_UNIX表示以文件方式创建socket，AF_INET表示以端口方式创建socket（我们会在后面详细讲解AF_INET）

	type：指定socket的类型，可以是SOCK_STREAM或SOCK_DGRAM
	SOCK_STREAM表示创建一个有序的，可靠的，面向连接的socket，因此如果我们要使用TCP，就应该指定为SOCK_STREAM
	SOCK_DGRAM表示创建一个不可靠的，无连接的socket，因此如果我们要使用UDP，就应该指定为SOCK_DGRAM

	protocol：指定socket的协议类型，我们一般指定为0表示由第一第二两个参数自动选择。

	socket()函数返回新创建的socket，出错则返回-1


	2. 地址格式：

	常用的有两种socket域：AF_UNIX或AF_INET，因此就有两种地址格式：
	sockaddr_un和sockaddr_in，分别定义如下：

	struct sockaddr_un {
		sa_family_t sun_family;  /* AF_UNIX */
		char sun_path[];         /* pathname */
	}


	struct sockaddr_in {
		short int sin_family;          /* AF_INET */
		unsigned short int sin_port;   /* port number */
		struct in_addr sin_addr;       /* internet address */
	}

其中in_addr正是用来描述一个ip地址的：
    struct in_addr {
		unsigned long int s_addr;
	}

从上面的定义我们可以看出，sun_path存放socket的本地文件名，
sin_addr存放socket的ip地址，sin_port存放socket的端口号。

3. 创建完一个socket后，我们需要使用bind将其绑定：

 int bind(int socket, const struct sockaddr * address, size_t address_len)

	如果我们使用AF_UNIX来创建socket，相应的地址格式是sockaddr_un，
	而如果我们使用AF_INET来创建socket，相应的地址格式是sockaddr_in，
	因此我们需要将其强制转换为sockaddr这一通用的地址格式类型，而sockaddr_un
	中的sun_family和sockaddr_in中的sin_family分别说明了它的地址格式类型，
	因此bind()函数就知道它的真实的地址格式。第三个参数address_len则指明了
	真实的地址格式的长度。

	bind()函数正确返回0，出错返回-1


4. 接下来我们需要开始监听了：

 int listen(int socket, int backlog)

	backlog：等待连接的最大个数，如果超过了这个数值，则后续的请求连接将被拒绝

	listen()函数正确返回0，出错返回-1

 5. 接受连接：

 int accept(int socket, struct sockaddr * address, size_t * address_len)

	同样，第二个参数也是一个通用地址格式类型，这意味着我们需要进行强制类型转化

	这里需要注意的是，address是一个传出参数，它保存着接受连接的客户端的地址，如果我们不需要，将address置为NULL即可。

	address_len：我们期望的地址结构的长度，注意，这是一个传入和传出参数，传入
	时指定我们期望的地址结构的长度，如果多于这个值，则会被截断，而当accept()函数
	返回时，address_len会被设置为客户端连接的地址结构的实际长度。

	另外如果没有客户端连接时，accept()函数会阻塞

	accept()函数成功时返回新创建的socket描述符，出错时返回-1

 6. 客户端通过connect()函数与服务器连接：

 int connect(int socket, const struct sockaddr * address, size_t address_len)

	对于第二个参数，我们同样需要强制类型转换

	address_len指明了地址结构的长度

	connect()函数成功时返回0，出错时返回-1
7.

双方都建立连接后，就可以使用常规的read/write函数来传递数据了

 8.  
 通信完成后，我们需要关闭socket：

 int close(int fd)

	close是一个通用函数（和read，write一样），不仅可以关闭文件描述符，还可以关闭socket描述符
