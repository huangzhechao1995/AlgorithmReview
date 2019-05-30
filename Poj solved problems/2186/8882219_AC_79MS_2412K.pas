program POJ2186;
type link=^node;
 node=record
 r:longint;
 next:link;
 end;
var i,j,n,m,l,r,k:longint;
 map:array[1..10000] of link;
 map2:array[1..10000] of link;
 line:array[1..10000] of longint;
 color:array[1..10000] of longint;
 hash:array[1..10000] of boolean;
 len:array[1..10000] of longint;
 p,q:link;
 tot,cl:longint;
procedure dfs1(x:longint);
 var k:longint;
  p:link;
 begin
  hash[x]:=true;
  p:=map2[x];
  while p<>nil do
   begin
    k:=p^.r;
    if not hash[k] then dfs1(k);
    p:=p^.next;
   end;
  inc(tot); line[tot]:=x;
 end;
procedure work(x,cl:longint);
 var p:link;
  k:longint;
 begin
  color[x]:=cl;
  p:=map[x];
  while p<>nil do
   begin
   k:=p^.r;
   if color[k]=0 then work(k,cl);
   p:=p^.next;
   end;
 end;
begin

 readln(n,m);
 for i:=1 to n do
  map[i]:=nil;
 for i:=1 to m do
  begin
  readln(l,r);
  new(p); p^.r:=r; p^.next:=map[l]; map[l]:=p;
  new(p); p^.r:=l; p^.next:=map2[r];map2[r]:=p;
  end;
 tot:=0;
 for i:=1 to n do
  if not hash[i] then dfs1(i);
 cl:=0;
 for i:=n downto 1 do
  if color[line[i]]=0 then
  begin
   inc(cl);
   work(line[i],cl);
  end;
{ for j:=1 to cl do
  begin
  for i:=1 to n do
   if color[i]=j then write(i,' ');
  writeln;
  end;
}for i:=1 to n do
  begin
  p:=map[i];
  while p<>nil do
   begin
    k:=p^.r;
    if color[k]<>color[i] then inc(len[color[i]]);
    p:=p^.next;
   end;
  end;
 k:=0;
 for i:=1 to cl do
  if len[i]=0 then inc(k);
 if k=1 then
  for i:=1 to cl do
  if len[i]=0 then
  begin
   l:=0;
   for j:=1 to n do
    if color[j]=i then inc(l);
   writeln(l);
  end;
 if k<>1 then writeln(0);


end.