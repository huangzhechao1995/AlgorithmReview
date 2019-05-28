program poj3255;
 const maxm=100000+50;
       maxn=5000+50;
       modd=200000;
 type arr=record
  l,r,c:longint;
  end;
 var i,j,n,m,p,q,l,r,k:longint;
 e:array[1..maxm] of arr;
 pre:Array[1..maxn] of longint;
 dis:Array[0..1,1..maxn] of longint;
 hash:array[1..maxn] of boolean;
 line:Array[1..modd] of longint;
 min,block:longint;
procedure openfile;
 begin
 assign(input,'poj3255.in');
 assign(output,'poj3255.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; t,m:arr;
 begin
  i:=l; j:=r;
  m:=e[(l+r) div 2];
  repeat
   while e[i].l<m.l do inc(i);
   while e[j].l>m.l do dec(j);
   if i<=j then
    begin
    t:=e[i]; e[i]:=e[j]; e[j]:=t;
    inc(i); dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;
procedure SPFA(k,st:longint);
 var l,r,p,x,i:longint;
 begin
 fillchar(dis[k],sizeof(dis[k]),127);
 fillchar(hash,sizeof(hash),false);
 l:=1; r:=1; line[1]:=st;
 dis[k][st]:=0;
 while l<=r do
  begin
  x:=line[(l-1) mod modd+1]; hash[x]:=false;
  for i:=pre[x] to pre[x+1]-1 do
   begin
   p:=e[i].r;
   if dis[k][x]+e[i].c<dis[k][p] then
    begin
    dis[k][p]:=dis[k][x]+e[i].c;
    if not hash[p] then
     begin
     hash[p]:=true;
     inc(r); line[(r-1) mod modd+1]:=p;
     end;
    end;
   end;
  inc(l);
  end;
 end;
begin
//-----------------
 readln(n,m);
 for i:=1 to m do
  begin
  read(e[i].l,e[i].r,e[i].c);
  e[i+m].l:=e[i].r; e[i+m].r:=e[i].l; e[i+m].c:=e[i].c;
  end;
 m:=m*2;
 qsort(1,m);
 for i:=m downto 1 do
  pre[e[i].l]:=i;
 pre[n+1]:=m+1;
 for i:=n downto 1 do
  if pre[i]=0 then pre[i]:=pre[i+1];
//-----------------
 SPFA(0,1);
 SPFA(1,n);
//-----------------
 min:=dis[0][n]; block:=1000000000;
 for i:=1 to m do
  begin
  l:=e[i].l; r:=e[i].r;
  if (dis[0][l]+e[i].c+dis[1][r]<block)and(dis[0][l]+e[i].c+dis[1][r]<>min) then
   block:=dis[0][l]+e[i].c+dis[1][r];
  if (dis[1][l]+e[i].c+dis[0][r]<block)and(dis[1][l]+e[i].c+dis[0][r]<>min) then
   block:=dis[1][l]+e[i].c+dis[0][r];
  end;
 writeln(block);

end.