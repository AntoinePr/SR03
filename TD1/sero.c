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
	char returnMsg[100];
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
			printf("\nNew client !\n");
			printf("A child process has been created, PID: %d\n", pid);
		}
		else{//fils, socket de service
			char data[200];
			int receiving_data = 0;
			do{
				if(recv(newsd,&objet,sizeof(objet),0)<0)exit(-1);
				//sleep(1);
				printf("\n");
				
				// Temporary fix
				if(strcmp(objet,"")==0){
					continue;
				}
				
				// Starting to collect data
				if(strcmp(objet,"<<<<")==0){
					printf("Starting to collect data !\n");
					strcpy(returnMsg, "Starting to collect data !\n");
					receiving_data = 1;
				}
				else {
					// Case we are currently collecting data
					if(receiving_data){
						// If the client stops the data collection
						if(strcmp(objet,">>>>")==0){
							printf("Full data package received !!\n");
							receiving_data = 0;
							strcpy(returnMsg, "-> Full data package received !!\n");
							printf("\n------------------------------------------\n\n");
							printf("%s", data);
							printf("\n\n------------------------------------------\n\n");
							// Clean of data variable
							strcpy(data, "");
						}
						// Else we continue collecting the data
						else {
							printf("Data package received\n");
							strcpy(returnMsg, "Data package received\n");
							strcat(data, objet);
						}
					}
					// Case we aren't collecting data: we tell it to the client
					else {
						printf("Data received but no data collection started\n");
						strcpy(returnMsg, "Data received but no data collection started\n");
					}
				}
				printf("Object received: '%s' \n",objet);
				send(newsd,returnMsg,sizeof(returnMsg),0);
				
			}while(strcmp(objet,"-1")!=0);
			exit(0);
		}
	}while(1);

	return status;
}
