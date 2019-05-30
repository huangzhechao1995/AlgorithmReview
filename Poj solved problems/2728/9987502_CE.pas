program p2728;
//
const
    maxn=1000;
    oo=19920905;
    eee=10e-6;
//
type
    xyh=record
        x,y,h:longint;
    end;
    relation=record
        d:real; h:longint;
    end;
//
var
    poi:array[0..maxn] of xyh;
    g:array[0..maxn,0..maxn] of relation;
    d:array[0..maxn] of real;
    vis:array[0..maxn] of boolean;
    pre:array[0..maxn] of longint;
    n:longint;
    h,t:longint;
    zzl:real;
//
procedure init;
var i:longint;
begin
    readln(n);
    for i:=1 to n do
        with poi[i] do
        begin
            readln(x,y,h);
        end;
end;
//
function prime(r:real):real;
var i,k,j,p:longint;
    minn,tot:real;
    totd,toth:real;
begin
    for i:=1 to n do d[i]:=oo;
    fillchar(vis,sizeof(vis),0);
    fillchar(pre,sizeof(pre),0);
    d[1]:=0; tot:=0;  totd:=0; toth:=0;
    for k:=1 to n do
    begin
        minn:=oo;
        for i:=1 to n do
            if not vis[i] then
            if d[i]            begin
                minn:=d[i];
                p:=i;
            end;
        toth:=toth+g[pre[p]][p].h;
        totd:=totd+g[pre[p]][p].d;
        vis[p]:=true;
        tot:=tot+d[p];
        for i:=1 to n do
            if not vis[i] then
            begin
                minn:=g[p][i].h-g[p][i].d*r;
                if minn            end;
    end;
    prime:=toth/totd;
    zzl:=tot;
end;
//
procedure work;
var i,j:longint;
    l,r,x,ans:real;
begin
    fillchar(g,sizeof(g),0);
    for i:=1 to n do
        for j:=1 to n do
            with g[i][j] do
            begin
                d:=sqrt(sqr(poi[i].x-poi[j].x)+sqr(poi[i].y-poi[j].y));
                h:=abs(poi[i].h-poi[j].h);
            end;
    x:=0;
    repeat
        x:=prime(x);
    until abs(zzl)    writeln(x:0:3);
end;
//
begin
    {assign(input,'p2728.in');reset(input);
    assign(output,'p2728.out');rewrite(output);}
    init;
    while n<>0 do
    begin
        work;
        init;
    end;
   // close(input);close(output);
end.