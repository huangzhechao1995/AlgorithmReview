program poj3662;
 const maxn=1000+50; maxm=10000+50; maxv=100000000;
 type arr=record
  l,r,d:longint;
 end;
 var i,j,n,m,p,q,l,r,k:longint;
 e:array[1..maxm] of arr;
 pre:array[1..maxm] of longint;
 dis,cl,line:array[1..maxn] of longint;
 max,ans,mid,color:longint;

procedure openfile;
 begin
 assign(input,'poj3662.in');
 assign(output,'poj3662.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; m,t:arr;
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
procedure dye(x:longint);
 var i,j:longint;
 begin
 cl[x]:=color;
 for i:=pre[x] to pre[x+1]-1 do
  if (cl[e[i].r]=0)and(e[i].d<=mid) then dye(e[i].r);
 end;

procedure bfs;
 var i,j,l,r,x:longint;
 procedure expand(x:longint);
  var i,j,p:longint;
  begin
  for i:=1 to n do
   if cl[i]=x then
   begin
    for j:=pre[i] to pre[i+1]-1 do
     if dis[cl[e[j].r]]=maxv then
     begin dis[cl[e[j].r]]:=dis[x]+1; inc(r); line[r]:=cl[e[j].r]; end;
   end;
  end;
 begin
 for i:=1 to n do dis[i]:=maxv;
 l:=1; r:=1;
 dis[1]:=0; line[1]:=1;
 while l<=r do
  begin
  x:=line[l]; inc(l);
  expand(x);
  if dis[cl[n]]<>maxv then break;
  end;
 end;
begin

 readln(n,m,k);
 for i:=1 to m do
  begin
  read(e[i].l,e[i].r,e[i].d);
  e[i+m].l:=e[i].r; e[i+m].r:=e[i].l; e[i+m].d:=e[i].d;
  if e[i].d>max then max:=e[i].d;
  end;
//------------map making-------------
 qsort(1,2*m);
 for i:=2*m downto 1 do
  pre[e[i].l]:=i;
 pre[n+1]:=2*m+1;
 for i:=n downto 1 do
  if pre[i]=0 then pre[i]:=pre[i+1];
//-----------------------------------
 mid:=max;
 fillchar(cl,sizeof(cl),0); color:=0;
  for i:=1 to n do
   if cl[i]=0 then
    begin inc(color); dye(i); end;
 bfs;
 if dis[cl[n]]=maxv then begin writeln(-1); halt; end;
 l:=0; r:=max;
 while l<r do
  begin
  mid:=(l+r) div 2;
  fillchar(cl,sizeof(cl),0); color:=0;
  for i:=1 to n do
   if cl[i]=0 then
    begin inc(color); dye(i); end;
  bfs;
  if dis[cl[n]]<=k then r:=mid else l:=mid+1;
  end;
 writeln(l);

end.