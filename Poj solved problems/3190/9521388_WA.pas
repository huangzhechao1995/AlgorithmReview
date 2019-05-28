program poj3190;
 const maxn=55000; maxv=1000000+50;
 type arr=record
  l,r,num:longint;
  end;
 var i,j,n,m,p,q,l,r,k:longint;
// a,s:array[0..maxv] of longint;
 b:array[0..maxn] of arr;
 house:array[0..maxn] of longint;
 heap,num:array[0..maxn] of longint;
 tot:longint;
procedure openfile;
 begin
 assign(input,'poj3190.in');
 assign(output,'poj3190.out');
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
 m:=b[(l+r) div 2];
 repeat
  while b[i].l<m.l do inc(i);
  while b[j].l>m.l do dec(j);
  if i<=j then
   begin
   t:=b[i]; b[i]:=b[j]; b[j]:=t;
   inc(i); dec(j);
   end;
  until i>j;
 if l<j then qsort(l,j);
 if i<r then qsort(i,r);
 end;
procedure swap(a,b:longint);
 var t:longint;
 begin
 t:=heap[a]; heap[a]:=heap[b]; heap[b]:=t;
 t:=num[a];  num[a]:=num[b];   num[b]:=t;
 end;
procedure add(k,bian:longint);
 var i,p,t:longint;
 begin
 heap[tot]:=k; num[tot]:=bian;
 i:=tot;
 p:=i div 2;
 while (i<>1)and(heap[i]<heap[p]) do
  begin
  swap(i,p);
  i:=p; p:=i div 2;
  end;
 end;
procedure delete(var m:longint);
 var i,p,q,t,k:longint;
 begin
 m:=num[1];
 swap(1,tot);
 dec(tot);
 i:=1;
 p:=i*2; q:=i*2+1;
 while p<=tot do
  begin
  k:=i;
  if heap[p]<heap[i] then k:=p;
  if (q<=tot)and(heap[q]<heap[k]) then k:=q;
  if k<>i then
   begin
   swap(i,k);
   i:=k; p:=i*2; q:=i*2+1;
   end
  else break;
  end;
 end;
begin
 //openfile;
 readln(n);
 for i:=1 to n do
  begin
  read(b[i].l,b[i].r);
  b[i].num:=i;
  end;
 qsort(1,n);
 tot:=1; heap[1]:=b[1].r; num[1]:=1;
 house[1]:=1;
 for i:=2 to n do
  begin
  if heap[1]>=b[i].l then
   begin
   inc(tot); m:=tot;
   add(b[i].r,m);
   end
  else
   begin
   delete(m);
   inc(tot);
   add(b[i].r,m);
   end;
  house[b[i].num]:=m;
  end;
 writeln(tot);
 for i:=1 to n do
  writeln(house[i]);
 //closefile;
end.
