#include <iostream>   
using namespace std;  
__int64 exgcd(__int64 a, __int64 b, __int64 &x, __int64 &y)  
{  
    __int64 t, r;  
    if (b==0)  
    {  
        x = 1;  
        y = 0;  
        r = a;  
    }  
    else  
    {  
        r = exgcd(b, a%b, x, y);  
        t = x;  
        x = y;  
        y = t - a/b*y;  
    }  
    return r;  
}  
int main()  
{  
    __int64 x,y,m,n,l;  
    __int64 a, b, c, d, t, xx, yy;  
    while(scanf("%I64d %I64d %I64d %I64d %I64d", &x, &y, &m, &n, &l)!=EOF)  
    {  
        a = ((m-n)%l+l)%l;  
        b = l;  
        c = ((y-x)%l+l)%l;  
        d = exgcd(a, b, xx, yy);  
        if (c%d!=0)  
        {  
            printf("Impossible");  
        }  
        else  
        {  
            t = b/d;  
            xx *= c/d;  
            printf((xx%t+t)%t);  
        }  
    }  
    return 0;  
}  