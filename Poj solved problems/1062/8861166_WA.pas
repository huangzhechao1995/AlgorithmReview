program poj1062;
 type arr=record
  r,c:longint;
  end;
 const maxn=100000000000;
 var i,j,n,m,p,q,l,r,k:longint;
 map:array[0..100,0..100] of arr;
 a,b:array[0..100] of longint;
 len:array[0..100] of longint;
 small,big,ll,rr:longint;
 ans:int64;
procedure work(l,r:longint);
 var i,j,k,p,q,cost,time:longint;
  hash:array[0..100] of boolean;
  dis:array[0..100] of int64;
 begin
  fillchar(hash,sizeof(hash),false);
  for i:=0 to 100 do
   dis[i]:=maxn;
  dis[1]:=0; hash[1]:=true;
  for i:=1 to len[1] do
   dis[map[1,i].r]:=map[1,i].c;
  for time:=1 to n do
   begin
   q:=maxlongint; p:=0;
   for i:=0 to n do
    if not hash[i] then
     if dis[i]<q then
      begin
      q:=dis[i]; p:=i;
      end;
   hash[p]:=true;
   for i:=1 to len[p] do
    begin
    q:=map[p,i].r; cost:=map[p,i].c;
    if not hash[q] then
    if dis[p]+cost<dis[q] then
     dis[q]:=dis[p]+cost;
    end;
   end;
  if dis[0]<ans then ans:=dis[0];
 end;
begin
 readln(m,n);
 small:=1000; ans:=maxn;
 big:=0;
 for i:=1 to n do
  begin
  readln(a[i],b[i],len[i]);
  if b[i]<small then small:=b[i];
  if b[i]>big then big:=b[i];
  for j:=1 to len[i] do
   readln(map[i,j].r,map[i,j].c);
  inc(len[i]);
  map[i,len[i]].r:=0; map[i,len[i]].c:=a[i];
  end;
 a[0]:=0; b[0]:=b[1]; len[0]:=0;
 if big-small+1<=m then
  work(small,big)
 else
 begin
 l:=b[1]; r:=l+m-1;
 while (b[1]<=r)and(l>=small) do
  begin
  if r>big then
  begin
  dec(l); dec(r);
  continue;
  end;
  work(l,r);
  dec(l);
  dec(r);
  end;
 end;
writeln(ans);

end.
