program tryout;
 const maxn=1000+20;
 type arr=record
  h,w,v:longint;
  end;
 var i,j,n,m,p,q,l,r:longint;
  AA,BB,CC:longint;
  cow:array[1..maxn] of arr;
  a:array[1..maxn] of arr;
  b:array[1..maxn] of longint;
  heap:array[1..maxn*2] of longint;
  h,w,tot,z,ans:longint;
procedure openfile;
 begin
 assign(input,'tryout.in');
 assign(output,'tryout.out');
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
  m:=a[(l+r) div 2];
  repeat
   while a[i].v<m.v do inc(i);
   while a[j].v>m.v do dec(j);
   if i<=j then
    begin
    t:=a[i]; a[i]:=a[j]; a[j]:=t;
    inc(i);
    dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;
procedure qsort2(l,r:longint);
 var i,j,t,m:longint;
 begin
  i:=l; j:=r;
  m:=b[(l+r) div 2];
  repeat
   while b[i]<m do inc(i);
   while b[j]>m do dec(j);
   if i<=j then
    begin
    t:=b[i]; b[i]:=b[j]; b[j]:=t;
    inc(i);
    dec(j);
    end;
   until i>j;
  if l<j then qsort2(l,j);
  if i<r then qsort2(i,r);
 end;
procedure add(v:longint);
 var x,p,t:longint;
 begin
 inc(tot); heap[tot]:=v;
 x:=tot;
 while x>1 do
  begin
  p:=x div 2;
  if heap[x]<heap[p] then
   begin
    t:=heap[p]; heap[p]:=heap[x]; heap[x]:=t;
   end
  else break;
  x:=p;
  end;
 end;

procedure delete;
 var x,p,k,t:longint;
 begin
  heap[1]:=heap[tot]; dec(tot);
  x:=1;
  while x*2<=tot do
   begin
   p:=x*2;
   if (x*2+1<=tot)and(heap[x*2+1]<heap[x*2]) then p:=x*2+1;
   if heap[p]<heap[x] then
    begin t:=heap[p]; heap[p]:=heap[x]; heap[x]:=t; end
   else break;
   x:=p;
   end;
 end;
begin
// openfile;
 readln(n);
 readln(AA,BB,CC);
 for i:=1 to n do
  readln(cow[i].h,cow[i].w);
 for i:=1 to n do
  begin
  h:=cow[i].h; tot:=0;
  for j:=1 to n do
   if cow[j].H>=h then
    begin
    inc(tot); a[tot]:=cow[j]; a[tot].v:=AA*a[tot].h+BB*a[tot].w-CC-AA*h;
    b[tot]:=cow[j].w;
    end;
  qsort(1,tot);
  qsort2(1,tot);
  z:=tot;
  if z<=ans then continue;
  tot:=0;
  r:=1;
  for j:=1 to z do
   begin
   w:=b[j];
   while (heap[1]<w)and(tot>0) do delete;
   while (r<=z)and(BB*w>=a[r].v) do
    begin
    if a[r].W>=w then add(a[r].w);
    inc(r);
    end;
   if tot>ans then ans:=tot;
   end;
  end;
 writeln(ans);
 //closefile;
end.
