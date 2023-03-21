#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define MAX_LINE_LENGTH 1000
#define LETTER '1'
#define ZERO 0
#define NUMBER 123


int main (void)
{
	printf("%c\n", 'a');
	printf("x%x\n", 12288);
	printf("$%d.%c%d n\n", NUMBER, LETTER, ZERO);
	
	int i =0;
	while(true)
	{
		if(i<0)
			printf("neg");
		if (i<0)
			return;
		i=i+1;
	}
    /***
	FILE    *textfile;
    char    text[MAX_LINE_LENGTH];
    long    numbytes;

    textfile = fopen("C:\\Users\\micof\\Desktop\\school\\cs2253\\prog2\\MTH.txt", "r");
    if(textfile == NULL)
        return 1;

    while(fgets(text, MAX_LINE_LENGTH, textfile)){
        printf(text);
    }

    fclose(textfile);
    **/
    return 0;
}
