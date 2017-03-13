#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <netdb.h>
#include <unistd.h>

int main(int argc, char** argv){
	int sd; struct hostent *hp;
	char objet[40], response[100];
	struct sockaddr_in sin;
	sd =socket(AF_INET,SOCK_STREAM,IPPROTO_TCP);
	bzero(&sin,sizeof(sin));
	hp=gethostbyname(argv[1]);
	bcopy(hp->h_addr,&sin.sin_addr, hp->h_length);
	sin.sin_family=hp->h_addrtype;
	sin.sin_port=htons(atoi(argv[2]));
	
	bind(sd,(struct sockaddr*) &sin,sizeof(sin));
	
	connect(sd,(struct sockaddr *) &sin,sizeof(sin));
	do{
		printf("Que voulez-vous envoyer ? \n");
		scanf("%s",objet);
		send(sd,&objet,sizeof(char)*((int)strlen(objet)+1),0);
		
		if(recv(sd,&response,sizeof(response),0)<0)exit(-1);
		printf("Retour serveur: %s\n",response);
		
	}while(strcmp(objet,"-1")!=0);
	close(sd);
	return -1;
}
