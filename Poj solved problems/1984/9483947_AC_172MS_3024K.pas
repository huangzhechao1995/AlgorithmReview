program poj1984;
 const maxn=40000+100;
 type  tp=record
   x,y,l,num:longint;
   d:char;
   end;
 var i,j,n,m,p,q,l,r,k:longint;
 father:array[1..maxn] of longint;
 a:array[1..maxn] of tp;
 query:array[1..maxn] of tp;
 ans:array[1..maxn] of longint;
 com:array[1..maxn] of tp;
 x,y:longint;
 t,pp,qq:tp;
procedure openfile;
 begin
 assign(input,'poj1984.in');
 assign(output,'poj1984.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; m,t:tp;
 begin
  i:=l; j:=r;
  m:=query[(l+r) div 2];
  repeat
   while query[i].l<m.l do inc(i);
   while query[j].l>m.l do dec(j);
   if i<=j then
    begin
    t:=query[i];
    query[i]:=query[j];
    query[j]:=t;
    inc(i);
    dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;
function getfather(x:longint):longint;
 var p:longint;
 begin
 if father[x]=x then exit(x);
 p:=getfather(father[x]);
 a[x].x:=a[x].x+a[father[x]].x;
 a[x].y:=a[x].y+a[father[x]].y;
 father[x]:=p; exit(father[x]);
 end;
procedure change(var t:tp; ch:char; k:longint);
 begin
 case ch of
  'E': begin t.x:=k; t.y:=0; end;
  'W': begin t.x:=-k; t.y:=0; end;
  'N': begin t.x:=0; t.y:=k; end;
  'S': begin t.x:=0; t.y:=-k; end;
  end;
 end;
begin

 readln(n,m);
 for i:=1 to m do
  begin
  read(com[i].x,com[i].y,com[i].l);
  read(com[i].d);
  while not (com[i].d in ['E','W','S','N']) do read(com[i].d);
  readln;
  end;
 readln(k);
 for i:=1 to k do
  begin
  readln(query[i].x,query[i].y,query[i].l);
  query[i].num:=i;
  end;
 qsort(1,k);
 for i:=1 to n do
  father[i]:=i;
 j:=1;
 for i:=1 to m do
  begin
  p:=com[i].x; q:=com[i].y;
  x:=getfather(p); y:=getfather(q);
  change(t,com[i].d,com[i].l);
  father[x]:=y;
  a[x].x:=a[q].x+t.x-a[p].x;
  a[x].y:=a[q].y+t.y-a[p].y;
  while (query[j].l<=i)and(j<=k) do
   begin
   p:=query[j].x;   q:=query[j].y;
   x:=getfather(p); y:=getfather(q);
   if x<>y then
    begin ans[query[j].num]:=-1; inc(j); continue; end;
   ans[query[j].num]:=abs(a[p].x-a[q].x)+abs(a[p].y-a[q].y);
   inc(j);
   end;
  end;
 for i:=1 to k do
  writeln(ans[i]);

end.
