program poj3270;
 type arr=record
  v,num:int64;
 end;
 const maxn=10000+100;  maxv=10000000000000000;
 var i,j,n,m,l,r:longint;
 a:array[1..maxn] of arr;
 rank,small,sum,cl,b:array[1..maxn] of int64;
 p,q,tot,minn,ans,k:int64;
procedure openfile;
 begin
 assign(input,'poj3270.in');
 assign(output,'poj3270.out');
 reset(input); rewrite(output);
 end;
procedure closefile;
 begin
 close(input); close(output);
 end;
procedure qsort(l,r:longint);
 var i,j:longint; m,t:arr;
 begin
 i:=l; j:=r; m:=a[(l+r) div 2];
 repeat
  while a[i].v<m.v do inc(i);
  while a[j].v>m.v do dec(j);
   if i<=j then
   begin
   t:=a[i];
   a[i]:=a[j];
   a[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
function min(a,b:int64):int64;
 begin
  if a<b then exit(a) else exit(b);
 end;
procedure search(x:longint);
 begin
 cl[x]:=tot; inc(k);
 small[tot]:=min(small[tot],b[x]);
 sum[tot]:=sum[tot]+b[x];
 if rank[x]=tot then exit
  else search(rank[x]);
 end;
begin

 readln(n);
 minn:=1000000000;
 for i:=1 to n do
  begin
  read(a[i].v);
  b[i]:=a[i].v;
  if minn>b[i] then minn:=b[i];
  a[i].num:=i;
  end;
 qsort(1,n);
 for i:=1 to n do
  rank[a[i].num]:=i;
 tot:=0;
 for i:=1 to n do
  if cl[i]=0 then
  begin
  inc(tot);
  k:=0; small[tot]:=1000000000;
  search(i);
  p:=(k-2)*small[tot];
  q:=small[tot]+minn*(k+1);
  ans:=ans+min(p,q)+sum[tot];
  end;
 writeln(ans);

end.
