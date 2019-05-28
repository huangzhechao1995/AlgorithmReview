program poj2761;
 const maxn=100000+5; maxm=50000+10;
 type arr=record
  l,r,x,num:longint;
  end;
 var i,j,n,m,p,q,l,r:longint;
  tot,tt,t,ans   :longint;
  ask:array[1..maxm] of arr;
  size,left,right,k:array[1..maxn] of longint;
  a:array[1..maxn] of longint;
  outputline:array[1..maxn] of longint;
procedure openfile;
 begin
 assign(input,'poj.in');
 assign(output,'poj.out');
 reset(input);
 rewrite(output);
 end;
procedure closefile;
 begin
 close(input);
 close(output);
 end;
procedure lturn(var t:longint);
 var p:longint;
 begin
 p:=right[t];
 right[t]:=left[p];
 left[p]:=t;
 size[p]:=size[t];
 size[t]:=size[left[t]]+size[right[t]]+1;
 t:=p;
 end;

procedure rturn(var t:longint);
 var p:longint;
 begin
 p:=left[t];
 left[t]:=right[p];
 right[p]:=t;
 size[p]:=size[t];
 size[t]:=size[left[t]]+size[right[t]]+1;
 t:=p;
 end;
procedure maintain(var t:longint; flag:boolean);
 begin
 if not flag then
  if size[left[left[t]]]>size[right[t]] then
   rturn(t) else
  if size[right[left[t]]]>size[right[t]] then
   begin lturn(left[t]); rturn(t); end
  else exit;
 if flag then
  if size[right[right[t]]]>size[left[t]] then
   lturn(t) else
  if size[left[right[t]]]>size[left[t]] then
   begin
   rturn(right[t]);
   lturn(t);
   end
  else exit;
 maintain(left[t],false);
 maintain(right[t],true);
 maintain(t,false);
 maintain(t,true);
 end;
procedure qsort(l,r:longint);
 var i,j,m:longint; t:arr;
 begin
  i:=l; j:=r;
  m:=ask[(i+j) div 2].l;
  repeat
   while ask[i].l<m do inc(i);
   while ask[j].l>m do dec(j);
   if i<=j then
    begin
    t:=ask[i]; ask[i]:=ask[j]; ask[j]:=t;
    inc(i); dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;
procedure add(var t,v:longint);
 begin
 if t=0 then
  begin
  inc(tot);
  t:=tot;
  left[t]:=0; right[t]:=0;
  size[t]:=1; k[t]:=v;
  end
 else
  begin
  size[t]:=size[t]+1;
  if v>=k[t] then add(right[t],v)
   else add(left[t],v);
  maintain(t,t>=k[t]);
  end;
 end;

procedure delete(var t:longint; v:longint);
 var p,i,x:longint;
 begin
 dec(size[t]);
 if v=k[t] then
  begin
  if (left[t]=0)or(right[t]=0) then
   begin
   t:=left[t]+right[t];
   exit;
   end;
  x:=t;
  i:=left[t]; j:=x;
  while right[i]<>0 do
   begin j:=i; dec(size[i]); i:=right[i]; end;
  if j=x then left[j]:=left[i] else right[j]:=left[i];
  k[x]:=k[i]; size[x]:=size[left[x]]+size[right[x]]+1;
  exit;
  end;
 if v<k[t] then
  delete(left[t],v);
 if v>k[t] then
  delete(right[t],v);
 end;
function find(t:longint; x:longint):longint;
 begin
 if size[left[t]]=x-1 then exit(k[t]);
 if size[left[t]]>x-1 then exit(find(left[t],x));
 find:=find(right[t],x-size[left[t]]-1);
 end;
begin
 //openfile;
 readln(n,m);
 for i:=1 to n do
  read(a[i]);
 for i:=1 to m do
  begin
  read(ask[i].l,ask[i].r,ask[i].x);
  ask[i].num:=i;
  end;
 qsort(1,m);
 l:=1; r:=0;
 tot:=0; t:=0;
 for i:=1 to m do
  begin
  while r<ask[i].r do
   begin inc(r); add(t,a[r]); end;
  while l<ask[i].l do
   begin delete(t,a[l]); inc(l); end;
  ans:=find(t,ask[i].x);
  outputline[ask[i].num]:=ans;
  end;
 for i:=1 to m do
  writeln(outputline[i]);
// closefile;
end.
