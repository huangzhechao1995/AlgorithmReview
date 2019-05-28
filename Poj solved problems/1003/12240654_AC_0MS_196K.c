#include<stdio.h>

int main()
{
	int i,j,k,n,v1,v2,v;
	double sum=0;
	scanf("%d.%d",&v1,&v2);
	v=v1*100+v2;
	while (v!=0)
	{
		n=0;
		sum=0;
        while (1)
		{
			n++;
			sum+=(double)1/(n+1);
			if (sum*100+0.000001>v ) break;			
		}
		printf("%d card(s)\n",n);
		scanf("%d.%d",&v1,&v2);
	    v=v1*100+v2;
	}

}