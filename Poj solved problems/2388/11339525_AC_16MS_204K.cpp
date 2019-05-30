#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<queue>
#include<stack>
#include<string>
#include<map>
#include<algorithm>
#include<iostream>
#include<cstdio>
#include<fstream>
#include<cmath>
#include<vector>
#include<set>
#include<cstring>
#include<math.h>

using namespace std;

int n,k;
int a[10005];

void my_sort(int x,int y){
    if(x>=y-1) return;
    int key=x;
    int front=x,rear=x;
    while(++front<y&&a[front]<=a[key]);
    rear=front;
    while(rear<y){
        while(++rear<y&&a[rear]>=a[key]);
        if(rear<y){
            swap(a[front++],a[rear]);
        }
    }
    swap(a[key],a[front-1]);
    if(x<=k&&k<front-1) my_sort(x,front-1);
    if(front<=k&&k<y) my_sort(front,y);
}

int main(){
    while(~scanf("%d",&n)){
        for(int i=0;i<n;++i){
            scanf("%d",&a[i]);
        }
        k=n>>1;
        my_sort(0,n);
        printf("%d\n",a[k]);
    }
    return 0;
}
