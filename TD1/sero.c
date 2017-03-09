#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>
#include <sys/wait.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

void handler(int sig) {
	int status;
	wait(&status);
	printf("Zombie process handled\n");
}

int main(int argc, char** argv){
	
	//gestion des processus zombies
	signal(SIGCHLD, handler);
	
	int sd,newsd,pid,status=0; 
	char objet[20]; 
	char returnMsg[40];
	struct sockaddr_in sin, newsin;
	socklen_t lennewsin;
	
	sd =socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);
	bzero(&sin,sizeof(sin));
	sin.sin_family=AF_INET;
	sin.sin_port=htons(atoi(argv[1]));
	bind(sd,(struct sockaddr*) &sin,sizeof(sin));
	listen(sd,5);
	do{
		lennewsin = sizeof(newsin);
		newsd=accept(sd,(struct sockaddr *) &newsin, &lennewsin);
		pid=fork(); 
		if(pid==-1)return -2;//erreur
		if(pid!=0){
			//père, boucle sur accept
			printf("New client !\n");
			printf("A child process has been created, PID: %d\n", pid);
		}
		else{//fils, socket de service
			do{
				if(recv(newsd,&objet,sizeof(objet),0)<0)exit(-1);
				printf("Objet reçu: '%s' \n",objet);
				strcpy(returnMsg, "Objet reçu !");
				send(newsd,returnMsg,sizeof(returnMsg),0);
				//boucler
			}while(strcmp(objet,"-1")!=0);
			exit(0);
		}
	}while(1);

	return status;
}
