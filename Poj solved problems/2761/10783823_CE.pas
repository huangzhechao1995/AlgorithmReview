program poj2761;
 const maxn=100000+5; maxm=50000+10;
 type arr=record
  l,r:longint;
  end;
 var i,j,n,m,p,q,l,r,k:longint;
  tot,tt   :longint;
  ask:array[1..maxm] of longint;
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
procedure maintain(var t:longint flag:boolean);
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
   begin rturn(right[t]); lturn(t); end
  else break;
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
   while ask[j].r>m do dec(j);
   if i<=j then
    begin
    t:=ask[i]; ask[i]:=ask[j]; ask[j]:=t;
    inc(i); dec(j);
    end;
   until i>j;
  if l<j then qsort(l,j);
  if i<r then qsort(i,r);
 end;

begin
 openfile;
 readln(n,m);
 for i:=1 to m do
  read(ask[i].l,ask[i].r);
 qsort(1,m);

 closefile;
end.